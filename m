From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 Oct 2014 14:03:45 +0100
Subject: [PATCH v3 0/2] introduce GNTTABOP_cache_flush
Message-ID: <alpine.DEB.2.02.1410081400520.17038@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series introduces support for GNTTABOP_cache_flush to perform
cache maintenance operation on foreign pages and reverts the current
code based on XENFEAT_grant_map_identity.


Changes in v3:
- fix the cache maintenance op call to match what Linux does natively;
- update the hypercall interface to match Xen.

Changes in v2:
- remove the definition of XENFEAT_grant_map_identity;
- update the hypercall interface to match Xen;
- call the interface on a single page at a time.


Stefano Stabellini (2):
      xen/arm: remove handling of XENFEAT_grant_map_identity
      xen/arm: introduce GNTTABOP_cache_flush

 arch/arm/xen/enlighten.c            |    5 --
 arch/arm/xen/mm32.c                 |  108 +++++++----------------------------
 include/xen/interface/features.h    |    3 -
 include/xen/interface/grant_table.h |   19 ++++++
 4 files changed, 41 insertions(+), 94 deletions(-)

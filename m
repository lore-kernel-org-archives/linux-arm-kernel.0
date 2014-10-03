From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 3 Oct 2014 15:52:18 +0100
Subject: [PATCH v2 0/2] introduce XENMEM_cache_flush
Message-ID: <alpine.DEB.2.02.1410031549150.17038@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series introduces support for GNTTABOP_cache_flush to perform
cache maintenance operation on foreign pages and reverts the current
code based on XENFEAT_grant_map_identity.

Changes in v2:
- remove the definition of XENFEAT_grant_map_identity;
- update the hypercall interface to match Xen;
- call the interface on a single page at a time.

Stefano Stabellini (2):
      xen/arm: remove handling of XENFEAT_grant_map_identity
      xen/arm: introduce GNTTABOP_cache_flush

 arch/arm/xen/enlighten.c            |    5 --
 arch/arm/xen/mm32.c                 |  107 +++++++----------------------------
 include/xen/interface/features.h    |    3 -
 include/xen/interface/grant_table.h |   18 ++++++
 4 files changed, 39 insertions(+), 94 deletions(-)

From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 2 Oct 2014 11:06:45 +0100
Subject: [PATCH 0/2] introduce XENMEM_cache_flush
Message-ID: <alpine.DEB.2.02.1410021102480.17038@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series introduces support for XENMEM_cache_flush to perform
cache maintenance operation on foreign pages and reverts the current
code based on XENFEAT_grant_map_identity.


Stefano Stabellini (2):
      xen/arm: remove handling of XENFEAT_grant_map_identity
      xen/arm: introduce XENMEM_cache_flush

 arch/arm/xen/enlighten.c       |    5 --
 arch/arm/xen/mm32.c            |  100 +++++++---------------------------------
 include/xen/interface/memory.h |   16 +++++++
 3 files changed, 33 insertions(+), 88 deletions(-)

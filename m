From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Mon, 25 Oct 2010 14:10:02 -0500
Subject: [PATCHv5 0/4] omap: iovmm - fixes for iovmm module
Message-ID: <1288033806-1496-1-git-send-email-x0095840@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 5:
* Changes in "iommu: create new api to set valid da range"
  - Change range variables to platform data structure.

Version 4:
* Changes in "iommu: create new api to set valid da range"
  - Validate range for fixed address.
  - Change way of change boundaries to avoid possible overflow
    instead of style :
       start + bytes >= end     which start + end can overflow
    use style:
       end - start < bytes

Version 3:
* change patch 2 base on Felipe Contreras' comments,
  now it uses min_t and I deleted some blank lines.
* patch "create new api to set valid da range" is base on
  "iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF"
  patch and on Hiroshi's comments and now it is added to
  this set.

Version 2:
* Removed "iovmm: fixes for iovmm module" that patch was already
  sent.
* Modified "iovmm: fix roundup for next area and end check for the
  last area" patch, base on Davin Cohen's comments and rename it
  to a proper name that describes what it is doing now.

*** BLURB HERE ***

Fernando Guzman Lugo (4):
  iovmm: no gap checking for fixed address
  iovmm: add superpages support to fixed da address
  iovmm: replace __iounmap with omap_iounmap
  iommu: create new api to set valid da range

 arch/arm/plat-omap/include/plat/iommu.h |    3 +
 arch/arm/plat-omap/iommu.c              |   33 ++++++++++++
 arch/arm/plat-omap/iovmm.c              |   84 ++++++++++++++++++-------------
 3 files changed, 85 insertions(+), 35 deletions(-)

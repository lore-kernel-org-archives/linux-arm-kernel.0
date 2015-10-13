From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Tue, 13 Oct 2015 16:44:06 +0300
Subject: [PATCH] DT: ARM: pxa: Remove incorrect binding from documentation
Message-ID: <1444743846-25873-1-git-send-email-jarkko.nikula@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove "mrvl,lpss-ssp" property from documentation because LPSS SSP type is
for certain Intel platforms. I believe commit a6e56c28a178
("ARM: pxa: ssp: add DT bindings") added it by accident by copying all
enum pxa_ssp_type types from include/linux/pxa2xx_ssp.h.

Please note this was removed from arch/arm/plat-pxa/ssp.c by the
commit b692cb83b14d ("ARM: pxa: ssp: Fix build error by removing originally
incorrect DT binding").

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt b/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
index 669b8140dd79..d10cc06c0c37 100644
--- a/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
+++ b/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
@@ -10,7 +10,6 @@ Required properties:
 				mvrl,pxa168-ssp
 				mrvl,pxa910-ssp
 				mrvl,ce4100-ssp
-				mrvl,lpss-ssp
 
 	- reg:		The memory base
 	- dmas:		Two dma phandles, one for rx, one for tx
-- 
2.6.1

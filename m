From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 31 Aug 2018 15:47:45 +0300
Subject: [PATCHv2 3/4] arm64: dts: add support for building DT overlays
In-Reply-To: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
References: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
Message-ID: <1535719666-13595-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple support for building DT overlays. This just compiles any
given .dtso file under the base arch/arm64/boot/dts/*/ directory into
a .dtbo.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 106039d..f04c814 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -127,7 +127,7 @@ Image.%: Image
 zinstall install:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
-%.dtb: scripts
+%.dtb %.dtbo: scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
 
 PHONY += dtbs dtbs_install
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

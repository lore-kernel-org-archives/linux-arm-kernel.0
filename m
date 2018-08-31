From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 31 Aug 2018 15:47:43 +0300
Subject: [PATCHv2 1/4] ARM: dts: add support for building DT overlays
In-Reply-To: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
References: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
Message-ID: <1535719666-13595-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple support for building DT overlays. This just compiles any
given .dtso file under the base arch/arm/boot/dts directory into
a .dtbo.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d1516f8..ab555a0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -339,7 +339,7 @@ $(BOOT_TARGETS): vmlinux
 $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
-%.dtb: | scripts
+%.dtb %.dtbo: | scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
 
 PHONY += dtbs dtbs_install
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

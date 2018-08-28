From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 28 Aug 2018 15:32:06 +0300
Subject: [PATCH 1/7] kbuild: add support for building %.dtbo targets
In-Reply-To: <1535459532-17211-1-git-send-email-t-kristo@ti.com>
References: <1535459532-17211-1-git-send-email-t-kristo@ti.com>
Message-ID: <1535459532-17211-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for building DT overlay targets, which can be applied
either runtime or statically on top of base devicetree blobs. The
only supported runtime application of overlays right now is during
bootloader execution; if the bootloader in question supports this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/Makefile.lib | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 61e5966..527aab9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -292,6 +292,9 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
+	$(call if_changed_dep,dtc)
+
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
 # Bzip2
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

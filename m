From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 28 Jun 2013 09:41:02 +0530
Subject: [PATCH] ARM: dts: remove previously generated .dtb files on clean
Message-ID: <1372392662-6833-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*.dtb used to be generated in the *arch/arm/boot* directory
which is different from where it is generated now.
Current rules delete the previously generated files only for
*make dtbs*.
Let distclean delete all the generated dtb files.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f0895c5..d293167 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -219,4 +219,4 @@ endif
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 	$(Q)rm -f $(obj)/../*.dtb
 
-clean-files := *.dtb
+clean-files := *.dtb ../*.dtb
-- 
1.7.9.5

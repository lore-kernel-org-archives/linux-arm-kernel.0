From: nm@ti.com (Nishanth Menon)
Date: Tue, 22 Jan 2013 15:27:29 -0600
Subject: [PATCH] ARM: dts: remove generated .dtb files on clean
Message-ID: <1358890049-26981-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 5f300acd8ae9f3d4585154370012ffc5c665330f
(ARM: 7152/1: distclean: Remove generated .dtb files)
ensured that dtbs were cleaned up when they were in
arch/arm/boot.
However, with the following commit:
commit 499cd8298628eeabf0eb5eb6525d4faa0eec80d8
(ARM: dt: change .dtb build rules to build in dts directory)

make clean now leaves dtbs in arch/arm/boot/dts/
untouched. Include dts directory so that clean-files rule
from arch/arm/boot/dts/Makefile is invoked when make
clean is done.

Cc: Dirk Behme <dirk.behme@de.bosch.com>
CC: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index abfce28..3837f97 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -115,4 +115,4 @@ i:
 	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
 
-subdir-	    := bootp compressed
+subdir-	    := bootp compressed dts
-- 
1.7.9.5

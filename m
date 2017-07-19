From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 19 Jul 2017 10:05:49 -0700
Subject: [PATCH 1/2] arm64: dts: move ns2 into northstar2 directory
In-Reply-To: <1500483950-9217-1-git-send-email-scott.branden@broadcom.com>
References: <1500483950-9217-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1500483950-9217-2-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place northstar2 into its own subdirectory.  This helps as the number
of Broadcom boards grow and we can separate them per SoC.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/Makefile                        | 4 ++--
 arch/arm64/boot/dts/broadcom/northstar2/Makefile             | 6 ++++++
 arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-clock.dtsi | 0
 arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-svk.dts    | 0
 arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-xmc.dts    | 0
 arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2.dtsi       | 0
 6 files changed, 8 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/northstar2/Makefile
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-clock.dtsi (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-svk.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-xmc.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2.dtsi (100%)

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index f11bdd6..3eaef38 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,7 +1,7 @@
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
-dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-svk.dtb ns2-xmc.dtb
 
-dts-dirs	:= stingray
+dts-dirs	+= northstar2
+dts-dirs	+= stingray
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/Makefile b/arch/arm64/boot/dts/broadcom/northstar2/Makefile
new file mode 100644
index 0000000..e01a148
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/northstar2/Makefile
@@ -0,0 +1,6 @@
+dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-svk.dtb
+dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-xmc.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/broadcom/ns2-clock.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2-clock.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/ns2-clock.dtsi
rename to arch/arm64/boot/dts/broadcom/northstar2/ns2-clock.dtsi
diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/ns2-svk.dts
rename to arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
diff --git a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/ns2-xmc.dts
rename to arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/ns2.dtsi
rename to arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
-- 
2.5.0

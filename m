From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 19 Jul 2017 10:05:50 -0700
Subject: [PATCH 2/2] arm64: dts: move rpi into rpi directory
In-Reply-To: <1500483950-9217-1-git-send-email-scott.branden@broadcom.com>
References: <1500483950-9217-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1500483950-9217-3-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place rpi into its own subdirectory.  This helps as the number
of Broadcom boards grow and we can separate them per SoC.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/Makefile                      | 3 +--
 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi              | 1 -
 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi     | 1 -
 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi     | 1 -
 arch/arm64/boot/dts/broadcom/bcm283x.dtsi                  | 1 -
 arch/arm64/boot/dts/broadcom/rpi/Makefile                  | 5 +++++
 arch/arm64/boot/dts/broadcom/rpi/bcm2835-rpi.dtsi          | 1 +
 arch/arm64/boot/dts/broadcom/{ => rpi}/bcm2837-rpi-3-b.dts | 0
 arch/arm64/boot/dts/broadcom/{ => rpi}/bcm2837.dtsi        | 0
 arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-smsc9514.dtsi | 1 +
 arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-usb-host.dtsi | 1 +
 arch/arm64/boot/dts/broadcom/rpi/bcm283x.dtsi              | 1 +
 12 files changed, 10 insertions(+), 6 deletions(-)
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/rpi/Makefile
 create mode 120000 arch/arm64/boot/dts/broadcom/rpi/bcm2835-rpi.dtsi
 rename arch/arm64/boot/dts/broadcom/{ => rpi}/bcm2837-rpi-3-b.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{ => rpi}/bcm2837.dtsi (100%)
 create mode 120000 arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-smsc9514.dtsi
 create mode 120000 arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-usb-host.dtsi
 create mode 120000 arch/arm64/boot/dts/broadcom/rpi/bcm283x.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 3eaef38..1708ff5 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,6 +1,5 @@
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
-
 dts-dirs	+= northstar2
+dts-dirs	+= rpi
 dts-dirs	+= stingray
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi b/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
deleted file mode 120000
index 3937b77..0000000
--- a/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm2835-rpi.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi b/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
deleted file mode 120000
index dca7c05..0000000
--- a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi b/arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
deleted file mode 120000
index cbeebe3..0000000
--- a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm283x-rpi-usb-host.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm283x.dtsi b/arch/arm64/boot/dts/broadcom/bcm283x.dtsi
deleted file mode 120000
index 5f54e4c..0000000
--- a/arch/arm64/boot/dts/broadcom/bcm283x.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm283x.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/rpi/Makefile b/arch/arm64/boot/dts/broadcom/rpi/Makefile
new file mode 100644
index 0000000..d1a5606
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rpi/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/broadcom/rpi/bcm2835-rpi.dtsi b/arch/arm64/boot/dts/broadcom/rpi/bcm2835-rpi.dtsi
new file mode 120000
index 0000000..06e5aa0
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rpi/bcm2835-rpi.dtsi
@@ -0,0 +1 @@
+../../../../../arm/boot/dts/bcm2835-rpi.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/rpi/bcm2837-rpi-3-b.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
rename to arch/arm64/boot/dts/broadcom/rpi/bcm2837-rpi-3-b.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/rpi/bcm2837.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm2837.dtsi
rename to arch/arm64/boot/dts/broadcom/rpi/bcm2837.dtsi
diff --git a/arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-smsc9514.dtsi b/arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-smsc9514.dtsi
new file mode 120000
index 0000000..3eff817
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-smsc9514.dtsi
@@ -0,0 +1 @@
+../../../../../arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-usb-host.dtsi b/arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-usb-host.dtsi
new file mode 120000
index 0000000..2102a8c
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-usb-host.dtsi
@@ -0,0 +1 @@
+../../../../../arm/boot/dts/bcm283x-rpi-usb-host.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/rpi/bcm283x.dtsi b/arch/arm64/boot/dts/broadcom/rpi/bcm283x.dtsi
new file mode 120000
index 0000000..db7e86c
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rpi/bcm283x.dtsi
@@ -0,0 +1 @@
+../../../../../arm/boot/dts/bcm283x.dtsi
\ No newline at end of file
-- 
2.5.0

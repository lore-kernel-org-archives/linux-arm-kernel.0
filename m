From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 18 Aug 2016 11:42:06 +0100
Subject: [PATCH v3 2/2] ARM64: dts: bcm: Use a symlink to R-Pi dtsi files from
 arch=arm
In-Reply-To: <1471516926-11466-1-git-send-email-ijc@hellion.org.uk>
References: <1471516926-11466-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <1471516926-11466-2-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ../../../arm... style cross-references added by commit 9d56c22a7861
("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.") do not work in the
context of the split device-tree repository[0] (where the directory
structure differs). As with commit 8ee57b8182c4 ("ARM64: dts: vexpress: Use
a symlink to vexpress-v2m-rs1.dtsi from arch=arm") use symlinks instead.

[0] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: arm at kernel.org
---
v2: No more need for skeleton.dtsi since this was cleaned up in the previous
    patch
v3: Collected tags
---
 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi          | 1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts       | 4 ++--
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi              | 2 +-
 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi | 1 +
 arch/arm64/boot/dts/broadcom/bcm283x.dtsi              | 1 +
 5 files changed, 6 insertions(+), 3 deletions(-)
 create mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
 create mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
 create mode 120000 arch/arm64/boot/dts/broadcom/bcm283x.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi b/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
new file mode 120000
index 0000000..3937b77
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
@@ -0,0 +1 @@
+../../../../arm/boot/dts/bcm2835-rpi.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 6f47dd2..7841b72 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 #include "bcm2837.dtsi"
-#include "../../../../arm/boot/dts/bcm2835-rpi.dtsi"
-#include "../../../../arm/boot/dts/bcm283x-rpi-smsc9514.dtsi"
+#include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-smsc9514.dtsi"
 
 / {
 	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
index f2a31d0..8216bbb 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
@@ -1,4 +1,4 @@
-#include "../../../../arm/boot/dts/bcm283x.dtsi"
+#include "bcm283x.dtsi"
 
 / {
 	compatible = "brcm,bcm2836";
diff --git a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi b/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
new file mode 120000
index 0000000..dca7c05
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
@@ -0,0 +1 @@
+../../../../arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm283x.dtsi b/arch/arm64/boot/dts/broadcom/bcm283x.dtsi
new file mode 120000
index 0000000..5f54e4c
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm283x.dtsi
@@ -0,0 +1 @@
+../../../../arm/boot/dts/bcm283x.dtsi
\ No newline at end of file
-- 
2.8.1

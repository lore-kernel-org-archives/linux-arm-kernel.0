From: eric@anholt.net (Eric Anholt)
Date: Wed, 16 Dec 2015 15:55:12 -0800
Subject: [PATCH v2 5/8] ARM: bcm2835: Move the CPU/peripheral include out of
 common RPi DT.
In-Reply-To: <1450310115-22163-1-git-send-email-eric@anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
Message-ID: <1450310115-22163-6-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Raspberry Pi 2, we want to use the same general pin assignment
bits, but need to use bcm2836.dtsi for the CPU instead.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi       | 2 --
 5 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index b2bff43..228614f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -1,4 +1,5 @@
 /dts-v1/;
+#include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 668442b..ef54050 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -1,4 +1,5 @@
 /dts-v1/;
+#include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index eab8b591..86f1f2f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -1,4 +1,5 @@
 /dts-v1/;
+#include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index ff6b2d1..4859e9d 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -1,4 +1,5 @@
 /dts-v1/;
+#include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 3572f03..3afb9fe 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,5 +1,3 @@
-#include "bcm2835.dtsi"
-
 / {
 	memory {
 		reg = <0 0x10000000>;
-- 
2.6.2

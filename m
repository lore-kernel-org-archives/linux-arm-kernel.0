From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 13 May 2015 18:11:28 +0100
Subject: [PATCH 1/5] arm64: Juno: Fix the GIC node address label and the
 frequency of FAXI clock.
In-Reply-To: <1431537092-19597-1-git-send-email-Liviu.Dudau@arm.com>
References: <1431537092-19597-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1431537092-19597-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the review of the Juno DT files I've noticed that the GIC
node label had two digits swapped leading to a different address
being shown in the /sys/devices fs.

Sudeep also pointed that public revisions of the Juno documentation
list a different frequency for the FAXI system than what the one
I've been using when creating the DT file. Verified with the firmware
people to be the correct value in the shipped systems.

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm64/boot/dts/arm/juno-clocks.dtsi | 4 ++--
 arch/arm64/boot/dts/arm/juno.dts         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
index c9b89ef..25352ed 100644
--- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
@@ -36,9 +36,9 @@
 		clock-output-names = "apb_pclk";
 	};
 
-	soc_faxiclk: refclk533mhz {
+	soc_faxiclk: refclk400mhz {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <533000000>;
+		clock-frequency = <400000000>;
 		clock-output-names = "faxi_clk";
 	};
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 5e9110a..7ab0713 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -98,7 +98,7 @@
 		      <0x00000008 0x80000000 0x1 0x80000000>;
 	};
 
-	gic: interrupt-controller at 2c001000 {
+	gic: interrupt-controller at 2c010000 {
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
 		reg = <0x0 0x2c010000 0 0x1000>,
 		      <0x0 0x2c02f000 0 0x2000>,
-- 
2.3.6

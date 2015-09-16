From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 16 Sep 2015 18:16:38 +0100
Subject: [PATCH REPOST v6 7/8] arm64: dts: add CPU topology on Juno
In-Reply-To: <1442423799-23892-1-git-send-email-sudeep.holla@arm.com>
References: <1442423799-23892-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1442423799-23892-8-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CPU topology on Juno. It will be useful for ther other
IP blocks depending on this topology.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-r1.dts | 26 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts    | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index c62751153a4f..69130840c6cd 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -34,6 +34,32 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A57_0>;
+				};
+				core1 {
+					cpu = <&A57_1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&A53_0>;
+				};
+				core1 {
+					cpu = <&A53_1>;
+				};
+				core2 {
+					cpu = <&A53_2>;
+				};
+				core3 {
+					cpu = <&A53_3>;
+				};
+			};
+		};
+
 		A57_0: cpu at 0 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x0 0x0>;
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index d7cbdd482a61..ce1128a54c8d 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -34,6 +34,32 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A57_0>;
+				};
+				core1 {
+					cpu = <&A57_1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&A53_0>;
+				};
+				core1 {
+					cpu = <&A53_1>;
+				};
+				core2 {
+					cpu = <&A53_2>;
+				};
+				core3 {
+					cpu = <&A53_3>;
+				};
+			};
+		};
+
 		A57_0: cpu at 0 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x0 0x0>;
-- 
1.9.1

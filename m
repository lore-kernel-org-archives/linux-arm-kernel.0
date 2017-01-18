From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Jan 2017 12:12:52 +0000
Subject: [PATCH 3/3] arm64: dts: juno: Remove Motherboard USB node
In-Reply-To: <74595d6d866518db7cfabc39b4cf9b54d3be9bde.1484741104.git.robin.murphy@arm.com>
References: <74595d6d866518db7cfabc39b4cf9b54d3be9bde.1484741104.git.robin.murphy@arm.com>
Message-ID: <39868e0d327456be61aa9ac318fc2d958523a696.1484741104.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first batch of Juno boards included a discrete USB controller chip
as a contingency in case of issues with the USB 2.0 IP integrated into
the SoC. As it turned out, the latter was fine, and to the best of my
knowledge the motherboard USB was never even brought up and validated.

Since this also isn't present on later boards, and uses a compatible
string undocumented and unmatched by any driver in the kernel, let's
just tidy it away for ever to avoid any confusion.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 3ad4c3000611..098601657f82 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -131,13 +131,6 @@
 				vddvario-supply = <&mb_fixed_3v3>;
 			};
 
-			usb at 5,00000000 {
-				compatible = "nxp,usb-isp1763";
-				reg = <5 0x00000000 0x20000>;
-				bus-width = <16>;
-				interrupts = <4>;
-			};
-
 			iofpga at 3,00000000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
2.11.0.dirty

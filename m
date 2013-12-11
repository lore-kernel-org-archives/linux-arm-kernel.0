From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 13:13:22 +0000
Subject: [PATCH 2/6] arm64: dts: Add a virtio disk to the RTSM motherboard
In-Reply-To: <1386767606-6391-1-git-send-email-broonie@kernel.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
Message-ID: <1386767606-6391-2-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Hambleton <mahamble@broadcom.com>

Describe the virtio device so we can mount disk images in the simulator.

[Reduced the size of the region based on feedback from review -- broonie]

Signed-off-by: Mark Hambleton <mahamble@broadcom.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
index b45e5f39f577..2f2ecd217363 100644
--- a/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
@@ -183,6 +183,12 @@
 				clocks = <&v2m_oscclk1>, <&v2m_clk24mhz>;
 				clock-names = "clcdclk", "apb_pclk";
 			};
+
+			virtio_block at 0130000 {
+				compatible = "virtio,mmio";
+				reg = <0x130000 0x200>;
+				interrupts = <42>;
+			};
 		};
 
 		v2m_fixed_3v3: fixedregulator at 0 {
-- 
1.8.5.1

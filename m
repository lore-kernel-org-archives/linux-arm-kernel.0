From: wxt@rock-chips.com (Caesar Wang)
Date: Thu,  7 Jan 2016 16:25:55 +0800
Subject: [PATCH v2 12/12] ARM: dts: Add pl330-broken-no-flushp quirk for
 rk3036 SoCs
In-Reply-To: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452155155-16232-13-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pl330 integrated in rk3036platform doesn't support
DMAFLUSHP function. So we add arm,pl330-broken-no-flushp quirk
for it.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rk3036.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 6ff03e3..0168817 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -102,6 +102,7 @@
 		pdma: pdma at 20078000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x20078000 0x4000>;
+			arm,pl330-broken-no-flushp;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-- 
1.9.1

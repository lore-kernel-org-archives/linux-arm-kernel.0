From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 22 Jan 2016 19:06:49 +0800
Subject: [PATCH v7 6/9] ARM: dts: add pl330-broken-no-flushp quirk for rk3036
 SoCs
In-Reply-To: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1453460812-8498-7-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pl330 integrated in rk3036 platform that doesn't support
DMAFLUSHP function. So we add 'arm,pl330-broken-no-flushp' quirk
for rk3036.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 arch/arm/boot/dts/rk3036.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index ee457a2..242cafc 100644
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

From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 15 Jan 2016 21:49:56 +0800
Subject: [PATCH v3 9/9] ARM: dts: rockchip: add pl330-broken-no-flushp quirk
 for rk3036 SoCs
In-Reply-To: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452865796-23527-10-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pl330 integrated in rk3036 platform that doesn't support
DMAFLUSHP function. So we add 'arm,pl330-broken-no-flushp' quirk
for rk3036.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v3:
- fix the commit content in pl330* quirk patch.

 arch/arm/boot/dts/rk3036.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index f5ecfff..c029f6f 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -103,6 +103,7 @@
 		pdma: pdma at 20078000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x20078000 0x4000>;
+			arm,pl330-broken-no-flushp;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-- 
1.9.1

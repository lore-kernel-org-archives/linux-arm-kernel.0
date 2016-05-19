From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 19 May 2016 23:47:04 +0800
Subject: [PATCH 3/3] ARM: dts: rockchip: fixes the spi compatible for rk3036
In-Reply-To: <1463672824-15367-1-git-send-email-wxt@rock-chips.com>
References: <1463672824-15367-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1463672824-15367-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That's seem the incorrect string to match the spi driver.

Fixes commit f629fcfab2cd
("ARM: dts: rockchip: support the spi for rk3036")

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org

---

 arch/arm/boot/dts/rk3036.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index d0f4bb7..a30700a 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -431,7 +431,7 @@
 	};
 
 	spi: spi at 20074000 {
-		compatible = "rockchip,rockchip-spi";
+		compatible = "rockchip,rk3036-spi";
 		reg = <0x20074000 0x1000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
-- 
2.7.4

From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 10 Jan 2017 14:15:29 +0800
Subject: [PATCH v4 1/2] arm64: dts: rockchip: add "rockchip,
 grf" property for RK3399 PMUCRU/CRU
In-Reply-To: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
References: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1484028930-20305-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The structure rockchip_clk_provider needs to refer the GRF regmap
in somewhere, if the CRU node has not "rockchip,grf" property,
calling syscon_regmap_lookup_by_phandle will return an invalid GRF
regmap, and the MUXGRF type clock will be not supported.

Therefore, we need to add them.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v4:
- separte the binding patch

Changes in v3:
- add optional roperty rockchip,grf in rockchip,rk3399-cru.txt

Changes in v2:
- referring pmugrf for PMUGRU
- fix the typo "invaild" in COMMIT message

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index c928015..081621b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1077,6 +1077,7 @@
 	pmucru: pmu-clock-controller at ff750000 {
 		compatible = "rockchip,rk3399-pmucru";
 		reg = <0x0 0xff750000 0x0 0x1000>;
+		rockchip,grf = <&pmugrf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		assigned-clocks = <&pmucru PLL_PPLL>;
@@ -1086,6 +1087,7 @@
 	cru: clock-controller at ff760000 {
 		compatible = "rockchip,rk3399-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		assigned-clocks =
-- 
2.7.4

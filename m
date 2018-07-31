From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Tue, 31 Jul 2018 13:59:21 +0800
Subject: [PATCH v4 3/4] arm64: dts: rockchip: add io-domain to roc-rk3328-cc
In-Reply-To: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <1533016762-5268-4-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

It is necessary for the io domain setting of the SoC to match the voltage
supplied by the regulators.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1:
- Split from V0.

 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 246c317..b983abd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -208,6 +208,18 @@
 	};
 };
 
+&io_domains {
+	status = "okay";
+
+	vccio1-supply = <&vcc_io>;
+	vccio2-supply = <&vcc18_emmc>;
+	vccio3-supply = <&vcc_io>;
+	vccio4-supply = <&vcc_18>;
+	vccio5-supply = <&vcc_io>;
+	vccio6-supply = <&vcc_io>;
+	pmuio-supply = <&vcc_io>;
+};
+
 &pinctrl {
 	pmic {
 		pmic_int_l: pmic-int-l {
-- 
2.7.4

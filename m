From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 Oct 2018 12:38:19 +0200
Subject: [PATCH v3 6/7] ARM: dts: rockchip: add qos nodes found on rk3066 and
 rk3188
In-Reply-To: <20181023103820.6464-1-heiko@sntech.de>
References: <20181023103820.6464-1-heiko@sntech.de>
Message-ID: <20181023103820.6464-7-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QoS nodes keep information about priorites etc on the interconnect
and loose state when the power-domain gets disabled. Therefore the
power-domain driver stores the settings of available qos nodes and
restores them when the power-domain gets enabled again.

So add the qos nodes found on the Cortex-A9 socs from Rockchip, so
that they can then be connected to the power-domains.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index d752dc611fd7..97307a405e60 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -147,6 +147,46 @@
 		status = "disabled";
 	};
 
+	qos_gpu: qos at 1012d000 {
+		compatible = "syscon";
+		reg = <0x1012d000 0x20>;
+	};
+
+	qos_vpu: qos at 1012e000 {
+		compatible = "syscon";
+		reg = <0x1012e000 0x20>;
+	};
+
+	qos_lcdc0: qos at 1012f000 {
+		compatible = "syscon";
+		reg = <0x1012f000 0x20>;
+	};
+
+	qos_cif0: qos at 1012f080 {
+		compatible = "syscon";
+		reg = <0x1012f080 0x20>;
+	};
+
+	qos_ipp: qos at 1012f100 {
+		compatible = "syscon";
+		reg = <0x1012f100 0x20>;
+	};
+
+	qos_lcdc1: qos at 1012f180 {
+		compatible = "syscon";
+		reg = <0x1012f180 0x20>;
+	};
+
+	qos_cif1: qos at 1012f200 {
+		compatible = "syscon";
+		reg = <0x1012f200 0x20>;
+	};
+
+	qos_rga: qos at 1012f280 {
+		compatible = "syscon";
+		reg = <0x1012f280 0x20>;
+	};
+
 	usb_otg: usb at 10180000 {
 		compatible = "rockchip,rk3066-usb", "snps,dwc2";
 		reg = <0x10180000 0x40000>;
-- 
2.18.0

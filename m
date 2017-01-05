From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  4 Jan 2017 18:21:28 -0600
Subject: [PATCH 06/12] ARM: dts: socfpga: add the LTC2977 power monitor on
 Arria10 devkit
In-Reply-To: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1483575694-29599-7-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the I2C LTC 2977 power monitor that is on the Arria10 devkit.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 17ec17a..4c99c99 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -145,6 +145,11 @@
 		compatible = "dallas,ds1339";
 		reg = <0x68>;
 	};
+
+	ltc at 5c {
+		compatible = "ltc2977";
+		reg = <0x5c>;
+	};
 };
 
 &uart1 {
-- 
2.7.4

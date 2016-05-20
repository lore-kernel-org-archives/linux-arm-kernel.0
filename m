From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 20 May 2016 15:32:04 +0530
Subject: [PATCH v3 3/4] ARM: dts: vfxxx: Add device tree node required by
 Vybrid SoC driver
In-Reply-To: <cover.1463737502.git.maitysanchayan@gmail.com>
References: <cover.1463737502.git.maitysanchayan@gmail.com>
Message-ID: <94eb84f49274732dce3390a217e4f37a81e50373.1463737502.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree node which will be used to bind the Vybrid
SoC driver and provide information adhering to the following:
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-soc

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 6c5222e..24979d6 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -770,5 +770,13 @@
 			compatible = "iio-hwmon";
 			io-channels = <&adc0 16>, <&adc1 16>;
 		};
+
+		vf610-soc {
+			compatible = "fsl,vf610-soc";
+			rom-revision = <&ocrom>;
+			mscm = <&mscm_cpucfg>;
+			nvmem-cells = <&ocotp_cfg0>, <&ocotp_cfg1>;
+			nvmem-cell-names = "cfg0", "cfg1";
+		};
 	};
 };
-- 
2.8.2

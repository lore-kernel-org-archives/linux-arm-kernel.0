From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 16 Jul 2015 19:03:36 +0530
Subject: [PATCH 2/2] ARM: dts: dra72-evm: fix compatible name for pcf8575
In-Reply-To: <cover.1437053417.git.nsekhar@ti.com>
References: <cover.1437053417.git.nsekhar@ti.com>
Message-ID: <79a8039fe923f38c2ea18de947e38d70c2d17bfc.1437053417.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compatible name "ti,pcf8575" used in dra72-evm.dts is not
documented in binding definitions nor is used by the
gpio-pcf857x driver.

The correct compatible to use is "nxp,pcf8575". Fix it.

The existing .dtb still works because i2c_device_match()
falls back to id table based matching if compatible match
fails.

Reported-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 4e1b60581782..746acce940c3 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -334,7 +334,7 @@
 	};
 
 	pcf_gpio_21: gpio at 21 {
-		compatible = "ti,pcf8575";
+		compatible = "nxp,pcf8575";
 		reg = <0x21>;
 		lines-initial-states = <0x1408>;
 		gpio-controller;
-- 
2.4.4.408.g16da57c

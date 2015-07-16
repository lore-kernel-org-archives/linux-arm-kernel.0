From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 16 Jul 2015 19:03:35 +0530
Subject: [PATCH 1/2] ARM: dts: dra7-evm: fix compatible name for pcf8575
In-Reply-To: <cover.1437053417.git.nsekhar@ti.com>
References: <cover.1437053417.git.nsekhar@ti.com>
Message-ID: <5b6c44c005b3628ce8c90f09ada673893129fb06.1437053417.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compatible name "ti,pcf8575" used in dra7-evm.dts is not
documented in binding definitions nor is used by the
gpio-pcf857x driver.

The correct compatible to use is "nxp,pcf8575". Fix it.

The existing .dtb works in spite of this issue because
i2c_device_match() falls back to id table based matching
if compatible match fails.

Reported-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index aa465904f6cc..5f33556175da 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -401,7 +401,7 @@
 	};
 
 	pcf_gpio_21: gpio at 21 {
-		compatible = "ti,pcf8575";
+		compatible = "nxp,pcf8575";
 		reg = <0x21>;
 		lines-initial-states = <0x1408>;
 		gpio-controller;
-- 
2.4.4.408.g16da57c

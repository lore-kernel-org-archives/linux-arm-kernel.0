From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:49 +0100
Subject: [PATCH 09/19] ARM: ux500: Enable SSP (SPI) for HREF when booting
 Device Tree
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1347016499-29354-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add a new SSP node to the HREF's Device Tree file which
activates the generic one found in the .dtsi file. This will
allow probing of the SSP driver when Device Tree is enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index d8ed29e..49bdabd 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -92,5 +92,9 @@
 		msp3: msp at 80125000 {
 			status = "okay";
 		};
+
+		ssp at 80002000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5

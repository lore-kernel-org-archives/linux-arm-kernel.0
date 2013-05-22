From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 15:49:57 +0100
Subject: [PATCH v2] ARM: ux500: Apply other compatible name to the u8540 DTS
 file
In-Reply-To: <1369233402-19225-1-git-send-email-lee.jones@linaro.org>
References: <1369233402-19225-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130522144957.GA18714@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: ux500: Apply other compatible name to the u8540 DTS file
    
Devices in board DTS files are usually searchable by multiple
compatible strings. In this case the 8540 based SoC should be
obtainable via the chipset [DB8540 & AB8540] name 'u8540' or
the board name 'ccu8540'. It's already possible to obtain the
Device Tree via its chipset name, this patch makes it possible
to get it by its board name too.
    
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/arch/arm/boot/dts/ccu8540.dts b/arch/arm/boot/dts/ccu8540.dts
index 18daa01..af4487f 100644
--- a/arch/arm/boot/dts/ccu8540.dts
+++ b/arch/arm/boot/dts/ccu8540.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "ST-Ericsson U8540 platform with Device Tree";
-	compatible = "st-ericsson,u8540";
+	compatible = "st-ericsson,ccu8540", "st-ericsson,u8540";
 
 	memory {
 		reg = <0x00000000 0x20000000>;

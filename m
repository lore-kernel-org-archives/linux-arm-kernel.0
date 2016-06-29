From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 16:04:33 +0200
Subject: [PATCH 3/4] ARM: dts: sun7i-a20-wits-pro-a20-dkt: Set brcm,
 nvram_file_name
In-Reply-To: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467209074-15634-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wits pro uses an ap6476 sdio wifi module, we do not have a nvram file
for this, so set brcm,nvram_file_name to brcmfmac43362-ap6210.txt which
works fine for this wifi module.

Setting brcm,nvram_file_name allows us to ship the ap6210 specific nvram
file in linux-firmware to get the wifi to work out of the box without
users needing to download and install the nvram file themselves.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index dc31d47..3c5455a9 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -140,6 +140,7 @@
 	brcmf: bcrmf at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
+		brcm,nvram_file_name = "brcm/brcmfmac43362-ap6210.txt";
 		interrupt-parent = <&pio>;
 		interrupts = <7 10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
 		interrupt-names = "host-wake";
-- 
2.7.4

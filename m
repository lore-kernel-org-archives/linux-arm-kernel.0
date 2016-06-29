From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 16:04:32 +0200
Subject: [PATCH 2/4] ARM: dts: sun7i-a20-cubietruck: Set brcm,nvram_file_name
In-Reply-To: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467209074-15634-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cubietruck uses an ap6210 sdio wifi module, set brcm,nvram_file_name
to brcmfmac43362-ap6210.txt so that we can ship the ap6210 specific
nvram file in linunx-firmware to get the wifi to work out of the box
without users needing to download and install the nvram file themselves.

Note a downside of this patch is that users who have already manually
installed the nvram file will need to rename it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 83f39b0..fda1da4 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -199,6 +199,7 @@
 	brcmf: bcrmf at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
+		brcm,nvram_file_name = "brcm/brcmfmac43362-ap6210.txt";
 		interrupt-parent = <&pio>;
 		interrupts = <7 10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
 		interrupt-names = "host-wake";
-- 
2.7.4

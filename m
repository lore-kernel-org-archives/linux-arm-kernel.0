From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 16:04:34 +0200
Subject: [PATCH 4/4] ARM: dts: sun5i-a10s-auxtek-t004: Set brcm,
 nvram_file_name
In-Reply-To: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467209074-15634-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The auxtek t004 uses a toc9002 sdio wifi module, the android nvram file
for this is for an older firmware which does not work with the mainline
kernel driver.

So we set brcm,nvram_file_name to brcmfmac43362-ap6210.txt which
works fine for this wifi module.

Setting brcm,nvram_file_name allows us to ship the ap6210 specific nvram
file in linux-firmware to get the wifi to work out of the box without
users needing to download and install the nvram file themselves.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index a790ec8..e15d1ef 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -118,6 +118,12 @@
 	non-removable;
 	cap-sdio-irq;
 	status = "okay";
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		brcm,nvram_file_name = "brcm/brcmfmac43362-ap6210.txt";
+	};
 };
 
 &ohci0 {
-- 
2.7.4

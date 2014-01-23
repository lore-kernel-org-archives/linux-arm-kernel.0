From: syin@broadcom.com (Sherman Yin)
Date: Thu, 23 Jan 2014 12:44:43 -0800
Subject: [PATCH v2 0/4] pinctrl: Rename Broadcom Capri pinctrl driver
In-Reply-To: <1390343886-25852-1-git-send-email-syin@broadcom.com>
References: <1390343886-25852-1-git-send-email-syin@broadcom.com>
Message-ID: <1390509887-19278-1-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be consistent with other Broadcom drivers, the Broadcom Capri pinctrl
driver and its related CONFIG option are renamed to bcm281xx.

Devicetree compatible string and binding documentation use
"brcm,bcm11351-pinctrl" to match the machine binding here:
Documentation/devicetree/bindings/arm/bcm/bcm11351.txt

This driver supports pinctrl on BCM11130, BCM11140, BCM11351, BCM28145
and BCM28155 SoCs.

Signed-off-by: Sherman Yin <syin@broadcom.com>
Reviewed-by: Matt Porter <mporter@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v2: split single patch into 4 patches

Sherman Yin (4):
  pinctrl: Rename Broadcom Capri pinctrl binding
  pinctrl: Rename Broadcom Capri pinctrl driver
  Update bcm_defconfig with new pinctrl CONFIG
  Update dtsi with new pinctrl compatible string

 ...capri-pinctrl.txt => brcm,bcm11351-pinctrl.txt} |    8 +-
 arch/arm/boot/dts/bcm11351.dtsi                    |    2 +-
 arch/arm/configs/bcm_defconfig                     |    2 +-
 drivers/pinctrl/Kconfig                            |    8 +-
 drivers/pinctrl/Makefile                           |    2 +-
 .../{pinctrl-capri.c => pinctrl-bcm281xx.c}        | 1521 ++++++++++----------
 6 files changed, 775 insertions(+), 768 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{brcm,capri-pinctrl.txt => brcm,bcm11351-pinctrl.txt} (98%)
 rename drivers/pinctrl/{pinctrl-capri.c => pinctrl-bcm281xx.c} (25%)

-- 
1.7.9.5

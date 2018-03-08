From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 8 Mar 2018 11:08:50 +0800
Subject: [PATCH v3 0/4] PINCTRL: Mediatek pinctrl driver for mt2712
In-Reply-To: <1520249745-6757-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1520249745-6757-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1520478530.4049.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Zhiyong

you should checkpatch every patch before sending them out

because I saw tons of check messages like below result for scanning v3
3/4

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#152: FILE: drivers/pinctrl/mediatek/pinctrl-mt2712.c:85:
+static int mt2712_spec_pull_set(struct regmap *regmap, unsigned int
pin,
+               unsigned char align, bool isup, unsigned int r1r0)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#353: FILE: drivers/pinctrl/mediatek/pinctrl-mt2712.c:286:
+static int mt2712_ies_smt_set(struct regmap *regmap, unsigned int pin,
+               unsigned char align, int value, enum pin_config_param
arg)

CHECK:LINE_SPACING: Please don't use multiple blank lines
#423: FILE: drivers/pinctrl/mediatek/pinctrl-mt2712.c:356:
+
+

CHECK:LINE_SPACING: Please don't use multiple blank lines
#473: FILE: drivers/pinctrl/mediatek/pinctrl-mt2712.c:406:
+
+

CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#719: FILE: drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h:14:
+       MTK_PIN(

CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#731: FILE: drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h:26:
+       MTK_PIN(

CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#742: FILE: drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h:37:
+       MTK_PIN(

....

total: 0 errors, 1 warnings, 214 checks, 2619 lines checked




On Mon, 2018-03-05 at 19:35 +0800, Zhiyong Tao wrote:
> This series includes four patches:
> 1.Add mt2712 pintcrl head file.
> 2.Add mt2712 pinctrl device node.
> 3.Add mt2712 pinctrl driver.
> 4.Support bias-disable of generic and special pins simultaneously.
> 
> Changes in patch v3:
> 1)Use SPDX identifiers for all new files.
> 2)Use right data for Copyright and Author.
> 3)Correct some spelling mistake.
> 4)Reusing original logic and change solution to support bias-disable of generic and special pins simultaneously.
> 5)Add some comments for the speical path of special pins bias-disable.
> 
> Changes in patch v2:
> 1)Separate patch4 for supporting bias-disable of generic and special pins.
> 2)GPIO16~17 direction setting is changed as generic pins in mt2712 E2,
>   So remove GPIO16~17 special direction setting and remove apmixedsys node in pinctrl device node.
> 3)Add pinmux define in "mt2712-pinfunc.h" and "pinctrl-mtk-mt2712.h" for mt2712 E2 design.
> 
> Zhiyong Tao (4):
>   arm64: dts: mt2712: add pintcrl file
>   arm64: dts: mt2712: add pintcrl device node.
>   pinctrl: add mt2712 pinctrl driver
>   pintcrl: support bias-disable of generic and special pins
>     simultaneously
> 
>  arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h | 1123 ++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   18 +
>  drivers/pinctrl/mediatek/Kconfig              |    7 +
>  drivers/pinctrl/mediatek/Makefile             |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt2712.c     |  632 ++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    6 +
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h | 1967 +++++++++++++++++++++++++
>  7 files changed, 3754 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
> 
> --
> 2.6.4 
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Apr 2015 10:31:16 +0200
Subject: [PATCH v2 1/5] mmc: dt-bindings: add Mediatek MMC bindings
In-Reply-To: <1426562035-16709-2-git-send-email-chaotian.jing@mediatek.com>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-2-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20150420083116.GQ4946@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chaotian,

On Tue, Mar 17, 2015 at 11:13:51AM +0800, Chaotian Jing wrote:
> Document the device-tree binding of Mediatek MMC host
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 33 ++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> new file mode 100644
> index 0000000..ac43f77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -0,0 +1,33 @@
> +* MTK MMC controller
> +
> +The MTK  MSDC can act as a MMC controller
> +to support MMC, SD, and SDIO types of memory cards.
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the msdc driver.
> +
> +Required properties:
> +- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc".
> +- interrupts: Should contain MSDC interrupt number
> +- clocks: MSDC source clock
> +- clock-names: "source"

When I remove the clk_ignore_unused from the command line SD/MMC stops
working on the MT8173. This is because msdc50_0_h_sel is disabled, when
I enable this clock SD/MMC works again. This clock should probably be
added here and handled appropriatly in the driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

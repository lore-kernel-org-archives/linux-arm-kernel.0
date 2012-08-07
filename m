From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Tue, 7 Aug 2012 16:04:01 +0800
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAP1dx+wRZea8o8KTGRDCMtQkt7EjDRN5EoFek80OKqJgTxbvZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for the work. :)

Some minor format comment.
On 2 August 2012 23:39, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
........
> +Required properties:
> +- compatible: "fsl,imx35-iomuxc"
> +- fsl,pins: two integers array, represents a group of pins mux and config
> +  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
> +  pin working on a specific function, CONFIG is the pad setting value like
> +  pull-up for this pin. Please refer to imx53 datasheet for the valid pad
s/imx53/imx35

> +See below for available PIN_FUNC_ID for imx35:
> +# grep '   IMX_PIN_REG' drivers/pinctrl/pinctrl-imx35.c | awk '{ print NR-1 " " $8 }'
> +0 MX35_PAD_CAPTURE__GPT_CAPIN1
> +1 MX35_PAD_CAPTURE__GPT_CMPOUT2
I'm not sure if you can use the format as exist IMX PIN_FUNC_ID tables as:
MX35_PAD_CAPTURE__GPT_CAPIN1        0
MX35_PAD_CAPTURE__GPT_CMPOUT2    1
Maybe the difficulty is the command (i did not know how to do it before),
If you know, we can do like that.
Anyway, it's not a big issue and does not block an ack.

> +enum imx35_pads {
> +       /* sed -r -n 's@^#define MX35_PAD_([0-9A-Z_]*)__([0-9A-Z_]*)\s+IOMUX_PAD\(\s*([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9]*),\s*NO_PAD_CTRL\)@\tMX35_PAD_\1, at p' arch/arm/plat-mxc/include/mach/iomux-mx35.h | uniq */
> +       MX35_PAD_CAPTURE,
> +       MX35_PAD_COMPARE,
> +       MX35_PAD_WDOG_RST,
> +       MX35_PAD_GPIO1_0,
> +       MX35_PAD_GPIO1_1,
> +       MX35_PAD_GPIO2_0,
> +       MX35_PAD_GPIO3_0,
Can we use the format as exist one?
enum imx53_pads {
        MX53_PAD_GPIO_19 = 1,
        MX53_PAD_KEY_COL0 = 2,
        MX53_PAD_KEY_ROW0 = 3,
        MX53_PAD_KEY_COL1 = 4,
.......
}
Then people can easy know its pin id.
I'm wondering there may be still some debug info are using pin id
then the above format helps.

.......
> +module_exit(imx35_pinctrl_exit);
> +MODULE_AUTHOR("Dong Aisheng <dong.aisheng@linaro.org>");
Not your name?

Otherwise,
you can add my ACK.

Regards
Dong Aisheng

From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 20 Feb 2015 00:47:39 +0200
Subject: [PATCH v2 1/3] ARM: dts: omap3-pandora: add common device tree
In-Reply-To: <1424202743-26387-2-git-send-email-marek@goldelico.com>
References: <1424202743-26387-1-git-send-email-marek@goldelico.com>
 <1424202743-26387-2-git-send-email-marek@goldelico.com>
Message-ID: <CANOLnOO9xPtaPTXxdZhh3KwU1Ai0XqTDOCkXgiJ7eg6bYKnDBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 9:52 PM, Marek Belisko <marek@goldelico.com> wrote:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>
> This device tree allows to boot, supports the panel,
> framebuffer, touch screen, as well as some more peripherals.
> Since there is a OMAP3530 based 600 MHz variant and a DM3730 based
> 1 GHz variant we must include this common device tree code
> in one of two CPU specific device trees.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-pandora-common.dtsi | 640 ++++++++++++++++++++++++++++
>  1 file changed, 640 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi
>
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> new file mode 100644
> index 0000000..78ef1ee
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> ...
> +
> +       penirq_pins: pinmux_penirq_pins {
> +               pinctrl-single,pins = <
> +                       /* here we could enable to wakeup the cpu from suspend by a pen touch */
> +                       OMAP3_CORE1_IOPAD(0x210c, MUX_MODE4)    /* GPIO_94 */

We need PIN_INPUT here, otherwise the touchscreen doesn't react to pen down.
(Sorry missed it last time).


Gra?vydas

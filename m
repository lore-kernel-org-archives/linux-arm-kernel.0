From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Jul 2017 15:57:28 +0800
Subject: [linux-sunxi] [PATCH v2 1/2] pinctrl: sunxi: add a missing
 function of A10/A20 pinctrl driver
In-Reply-To: <20170718074254.20732-2-icenowy@aosc.io>
References: <20170718074254.20732-1-icenowy@aosc.io>
 <20170718074254.20732-2-icenowy@aosc.io>
Message-ID: <CAGb2v67JzOW7-SevwcAbDBeQ7Y1aRS5dhpQYsxqwWbOnJka=iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 3:42 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The PH16 pin has a function with mux id 0x5, which is the DET pin of the
> "sim" (smart card reader) IP block.
>
> This function is missing in old versions of A10/A20 SoCs' datasheets and
> user manuals, so it's also missing in the old drivers. The newest A10
> Datasheet V1.70 and A20 Datasheet V1.41 contain this pin function, and
> it's discovered during implementing R40 pinctrl driver.
>
> Add it to the driver. As we now merged A20 pinctrl driver to the A10
> one, we need to only fix the A10 driver now.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Fixes: f2821b1ca3a2 ("pinctrl: sunxi: Move Allwinner A10 pinctrl
driver to a driver of its own")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Not sure if Ccing stable is needed. There aren't likely to be any users,
as there is no driver for the smart card reader.

Also this wouldn't apply directly to old kernels anyway, due to the
newly merged in A20 driver.

ChenYu

> ---
> Changes in v2:
> - Commit message changes. (mentioning the datasheet versions which are
>   used to discover this pin function.)
>
>  drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> index 159580c04b14..47a392bc73c8 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> @@ -918,6 +918,7 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>                   SUNXI_FUNCTION_VARIANT(0x3, "emac",   /* ETXD1 */
>                                          PINCTRL_SUN7I_A20),
>                   SUNXI_FUNCTION(0x4, "keypad"),        /* IN6 */
> +                 SUNXI_FUNCTION(0x5, "sim"),           /* DET */
>                   SUNXI_FUNCTION_IRQ(0x6, 16),          /* EINT16 */
>                   SUNXI_FUNCTION(0x7, "csi1")),         /* D16 */
>         SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 17),
> --
> 2.13.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

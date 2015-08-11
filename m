From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 12 Aug 2015 00:48:50 +0800
Subject: [linux-sunxi] [PATCH] pinctrl: sun4i: add spdif to pin
 description.
In-Reply-To: <1439309965-9530-1-git-send-email-codekipper@gmail.com>
References: <1439309965-9530-1-git-send-email-codekipper@gmail.com>
Message-ID: <CAGb2v64Ptt5NgeicsYtiR8At+K4aDd3Lb3U4kijQ5UM+UafSrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:19 AM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> index 7376a97..daf7dec 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> @@ -135,7 +135,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>         SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
>                   SUNXI_FUNCTION(0x0, "gpio_in"),
>                   SUNXI_FUNCTION(0x1, "gpio_out"),
> -                 SUNXI_FUNCTION(0x2, "ir0")),          /* TX */
> +                 SUNXI_FUNCTION(0x2, "ir0"),           /* TX */
> +                 SUNXI_FUNCTION(0x4, "spdif")),        /* MCLK */
>         SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
>                   SUNXI_FUNCTION(0x0, "gpio_in"),
>                   SUNXI_FUNCTION(0x1, "gpio_out"),
> @@ -176,11 +177,13 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>                   SUNXI_FUNCTION(0x0, "gpio_in"),
>                   SUNXI_FUNCTION(0x1, "gpio_out"),
>                   SUNXI_FUNCTION(0x2, "i2s"),           /* DI */
> -                 SUNXI_FUNCTION(0x3, "ac97")),         /* DI */
> +                 SUNXI_FUNCTION(0x3, "ac97"),          /* DI */
> +                 SUNXI_FUNCTION(0x4, "spdif")),        /* DI */
>         SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
>                   SUNXI_FUNCTION(0x0, "gpio_in"),
>                   SUNXI_FUNCTION(0x1, "gpio_out"),
> -                 SUNXI_FUNCTION(0x2, "spi2")),         /* CS1 */
> +                 SUNXI_FUNCTION(0x2, "spi2"),          /* CS1 */
> +                 SUNXI_FUNCTION(0x4, "spdif")),        /* DO */

The datasheet and manual list them as NC or Reserved. Maybe mention how you knew
they were available?

Given that the S/PDIF block is not documented either, you should do
the same for the
actual driver, like mention Allwinner kernel sources.


ChenYu

>         SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 14),
>                   SUNXI_FUNCTION(0x0, "gpio_in"),
>                   SUNXI_FUNCTION(0x1, "gpio_out"),
> --
> 2.5.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Nov 2014 19:04:55 +0100
Subject: [PATCH 1/5] pinctrl: sun6i: Add some missing functions, fix i2c3
 muxing
In-Reply-To: <1416747283-13489-2-git-send-email-hdegoede@redhat.com>
References: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
 <1416747283-13489-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20141125180455.GA25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 23, 2014 at 01:54:39PM +0100, Hans de Goede wrote:
> While working on pinctrl for the A31s, I noticed that function 4 of
> PA15 - PA18 was missing, add these.
> 
> I also noticed that i2c3 sck / sda got assigned to PB5 & PB6, this should
> be PB4 & PB5, fix this as well.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
> index a2b4b85..fb19e15 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
> @@ -134,24 +134,28 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD4 */
>  		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D15 */
> +		  SUNXI_FUNCTION(0x4, "clk_a_out"),

It's called clk_out_a on the A20, I'd rather stick with the same
scheme here.

>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),	/* PA_EINT15 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 16),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD5 */
>  		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D16 */
> +		  SUNXI_FUNCTION(0x4, "dmic"),		/* CLK */
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),	/* PA_EINT16 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 17),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD6 */
>  		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D17 */
> +		  SUNXI_FUNCTION(0x4, "dmic"),		/* DIN */
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 17)),	/* PA_EINT17 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 18),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "gmac"),		/* RXD7 */
>  		  SUNXI_FUNCTION(0x3, "lcd1"),		/* D18 */
> +		  SUNXI_FUNCTION(0x4, "clk_b_out"),
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 18)),	/* PA_EINT18 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 19),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
> @@ -207,6 +211,7 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "gmac"),		/* MDC */
>  		  SUNXI_FUNCTION(0x3, "lcd1"),		/* HSYNC */
> +		  SUNXI_FUNCTION(0x4, "clk_c_out"),
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 26)),	/* PA_EINT26 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 27),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
> @@ -242,20 +247,20 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "i2s0"),		/* DO1 */
>  		  SUNXI_FUNCTION(0x3, "uart3"),		/* RTS */
> +		  SUNXI_FUNCTION(0x4, "i2c3"),		/* SCK */
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PB_EINT4 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "i2s0"),		/* DO2 */
>  		  SUNXI_FUNCTION(0x3, "uart3"),		/* TX */
> -		  SUNXI_FUNCTION(0x4, "i2c3"),		/* SCK */
> +		  SUNXI_FUNCTION(0x4, "i2c3"),		/* SDA */
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PB_EINT5 */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "i2s0"),		/* DO3 */
>  		  SUNXI_FUNCTION(0x3, "uart3"),		/* RX */
> -		  SUNXI_FUNCTION(0x4, "i2c3"),		/* SDA */

Where did you get that info from? The datasheet still reports that
information.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/dddf3a17/attachment.sig>

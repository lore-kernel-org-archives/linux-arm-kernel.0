From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Aug 2015 10:58:44 +0200
Subject: [linux-sunxi] [PATCH v2] pinctrl: sun4i: add spdif to pin
 description.
In-Reply-To: <1439400468-1563-2-git-send-email-codekipper@gmail.com>
References: <1439400468-1563-1-git-send-email-codekipper@gmail.com>
 <1439400468-1563-2-git-send-email-codekipper@gmail.com>
Message-ID: <55CC5C44.5060507@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12-08-15 19:27, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

LGTM:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> index 7376a97..862a096 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
> @@ -135,7 +135,14 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
> -		  SUNXI_FUNCTION(0x2, "ir0")),		/* TX */
> +		  SUNXI_FUNCTION(0x2, "ir0"),		/* TX */
> +		/*
> +		 * The SPDIF block is not referenced at all in the A10 user
> +		 * manual. However it is described in the code leaked and the
> +		 * pin descriptions are declared in the A20 user manual which
> +		 * is pin compatible with this device.
> +		 */
> +		  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF MCLK */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
> @@ -176,11 +183,15 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
>   		  SUNXI_FUNCTION(0x2, "i2s"),		/* DI */
> -		  SUNXI_FUNCTION(0x3, "ac97")),		/* DI */
> +		  SUNXI_FUNCTION(0x3, "ac97"),		/* DI */
> +		/* Undocumented mux function - See SPDIF MCLK above */
> +		  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF IN */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
> -		  SUNXI_FUNCTION(0x2, "spi2")),		/* CS1 */
> +		  SUNXI_FUNCTION(0x2, "spi2"),		/* CS1 */
> +		/* Undocumented mux function - See SPDIF MCLK above */
> +		  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF OUT */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 14),
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
>

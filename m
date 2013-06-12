From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 12 Jun 2013 12:56:13 +0200
Subject: [PATCHv4 4/9] i2c: mv64xxx: Add Allwinner sun4i compatible
In-Reply-To: <1371024438-16631-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130612105613.GT16502@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:07:13AM +0200, Maxime Ripard wrote:
> Add the compatible string for the Allwinner A10 i2c controller and the
> associated register layout.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/i2c/busses/Kconfig       |  3 ++-
>  drivers/i2c/busses/i2c-mv64xxx.c |  1 +
>  include/linux/mv643xx_i2c.h      | 10 ++++++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 631736e..5dc4148 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -507,10 +507,11 @@ config I2C_MPC
>  
>  config I2C_MV64XXX
>  	tristate "Marvell mv64xxx I2C Controller"
> -	depends on (MV64X60 || PLAT_ORION)
> +	depends on (MV64X60 || PLAT_ORION || ARCH_SUNXI)

Hi Maxime.

What about MV64X60? It also needs to pass the registers in its
platform data.

	 Andrew

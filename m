From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Jan 2015 09:44:56 +0100
Subject: [PATCH v4 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
In-Reply-To: <1421274213-3544-4-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-4-git-send-email-rjui@broadcom.com>
Message-ID: <20150115084456.GO22880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 14, 2015 at 02:23:33PM -0800, Ray Jui wrote:
> Add I2C device nodes and its properties in bcm-cygnus.dtsi but keep
> them disabled there. Individual I2C devices can be enabled in board
> specific dts file when I2C slave devices are enabled in the future
s/$/./

> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 5126f9e..f7d6c1d 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -70,6 +70,26 @@
>  		};
>  	};
>  
> +	i2c0: i2c at 18008000 {
> +		compatible = "brcm,iproc-i2c";
in patch 2 you wrote the driver is for a family of SoCs, right? Then I'd
make this:

	compatible = "brcm,$mysoc-iproc-i2c", "brcm,iproc-i2c";

(or maybe s/$mysoc-iproc-i2c/$mysoc-i2c/).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

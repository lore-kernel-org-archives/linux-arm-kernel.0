From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 17 Apr 2013 08:13:02 +0800
Subject: [PATCH] ARM i.MX53: dts: add i2c aliases
In-Reply-To: <1365527927-20618-1-git-send-email-p.zabel@pengutronix.de>
References: <1365527927-20618-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130417001300.GG11245@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 07:18:47PM +0200, Philipp Zabel wrote:
> This allows to order the i2c character devices correctly,
> so that /dev/i2c-0 corresponds to i2c1, /dev/i2c-1 corresponds
> to i2c2, and so on. Currently they are ordered by register
> address.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx53.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 845982e..7b9a391 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -27,6 +27,9 @@
>  		gpio4 = &gpio5;
>  		gpio5 = &gpio6;
>  		gpio6 = &gpio7;
> +		i2c0 = &i2c1;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c3;
>  	};
>  
>  	tzic: tz-interrupt-controller at 0fffc000 {
> -- 
> 1.8.2.rc2
> 

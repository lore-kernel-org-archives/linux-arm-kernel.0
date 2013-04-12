From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Apr 2013 12:02:08 +0800
Subject: [PATCH 4/4] ARM: dts: imx: imx53-qsb.dts: enable usbotg and usbh1
In-Reply-To: <1365675197-9687-5-git-send-email-m.grzeschik@pengutronix.de>
References: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
 <1365675197-9687-5-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20130412040206.GJ16970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 12:13:17PM +0200, Michael Grzeschik wrote:
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx53-qsb.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> index 05cc562..953b2d4 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -83,6 +83,14 @@
>  	};
>  };
>  
> +&usbotg {
> +       status = "okay";
> +};
> +
> +&usbh1 {
> +       status = "okay";
> +};
> +

It's my fault that those existing nodes did not get sorted well from day
one.  But let's do for new added ones.

I just put these two at the end of the file in the following order.

 &usbh1
 &usbotg

Shawn

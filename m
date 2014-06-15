From: ipaton0@gmail.com (Iain Paton)
Date: Sun, 15 Jun 2014 20:51:51 +0100
Subject: [PATCH 2/2] ARM: dts: imx6qdl: use DT macro for clock ID
In-Reply-To: <1402836147-29625-2-git-send-email-shawn.guo@freescale.com>
References: <1402836147-29625-1-git-send-email-shawn.guo@freescale.com>
 <1402836147-29625-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <539DF957.5080603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/06/14 13:42, Shawn Guo wrote:
> Switch to use DT macro for clock ID, so that device tree source is more
> readable.

[...]
>  		aips1: aips-bus at 02000000 {
> @@ -87,7 +90,8 @@
>  				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
>  				reg = <0x021f8000 0x4000>;
>  				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks 116>;
> +				/* Same clock as i.MX6Q ECSPI5 */
> +				clocks = <&clks IMX6QDL_CLK_ECSPI5>;
>  				status = "disabled";
>  			};
>  		};

Do you think it would it be worthwhile to define

+#define IMX6Q_CLK_ECSPI5	116
+#define IMX6DL_CLK_I2C4	116

in imx6qdl-clock.h from the first patch and use it here ?

I'm not particularly bothered either way, I just remember thinking the 
name in the enum could become a cause of confusion when I was looking 
at the changes for i2c4.

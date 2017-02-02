From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 2 Feb 2017 08:09:57 +0100
Subject: [PATCH v2] ARM: dts: i.MX25: add AIPS control registers
In-Reply-To: <1485987378-27784-1-git-send-email-martin@kaiser.cx>
References: <1485890402-22974-1-git-send-email-martin@kaiser.cx>
 <1485987378-27784-1-git-send-email-martin@kaiser.cx>
Message-ID: <20170202070957.zzmrutbgbv66cv5d@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Wed, Feb 01, 2017 at 11:16:18PM +0100, Martin Kaiser wrote:
> The i.MX25 contains two AHB to IP bridges (AIPS), each of which has a set of
> control registers. Add the memory regions for the control registers to
> the Device Tree.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>    removed the "fsl,imx53-aipstz" property as per Sascha's request
> 
>  arch/arm/boot/dts/imx25.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index e0ba550..1914858 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -93,6 +93,11 @@
>  			reg = <0x43f00000 0x100000>;
>  			ranges;
>  
> +			aips1: bridge at 43f00000 {
> +				compatible = "fsl,imx25-aips";
> +				reg = <0x43f00000 0x60>;
> +			};

One thing I haven't seen the first time: The size should be the size of
the while register space given to this device, not the position of the
last register, so 0x4000 instead of 0x60 here.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

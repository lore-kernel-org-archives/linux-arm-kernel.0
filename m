From: horms@verge.net.au (Simon Horman)
Date: Mon, 22 Aug 2016 09:41:11 +0200
Subject: [PATCH] ARM: dts: blanche: add DU support
In-Reply-To: <1783132.r9t2y3QUUq@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
 <1783132.r9t2y3QUUq@wasted.cogentembedded.com>
Message-ID: <20160822074111.GE28034@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Aug 19, 2016 at 11:42:54PM +0300, Sergei Shtylyov wrote:
> Define  the  Blanche board dependent part of the DU device node.
> Add the device nodes for the  Analog Devices ADV7511W  HDMI transmitter
> (connected to DU0) and ADV7123 video DAC (connected to DU1).  Add the
> necessary subnodes to interconnect DU, HDMI/VDAC devices, and HDMI/VGA
> connectors.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'renesas-devel-20160817-v4.8-rc2' of Simon Horman's
> 'renesas.git' repo plus the general purpose switches patch and the SDHI0 patch
> posted earlier.
> 
>  arch/arm/boot/dts/r8a7792-blanche.dts |  125 ++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts

...

> @@ -186,3 +251,63 @@
>  	cd-gpios = <&gpio11 11 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <400000>;

Is it intentional that there are no pinctrl properties here?

...

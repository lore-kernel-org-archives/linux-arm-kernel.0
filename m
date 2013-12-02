From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Dec 2013 11:53:03 +0000
Subject: [PATCH 2/2] ARM: dts: imx6q-udoo: Add USB host support
In-Reply-To: <1384394987-15134-2-git-send-email-festevam@gmail.com>
References: <1384394987-15134-1-git-send-email-festevam@gmail.com>
 <1384394987-15134-2-git-send-email-festevam@gmail.com>
Message-ID: <20131202115303.GH12952@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:09:47AM +0000, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Udoo board has USBH1 port connected to a USB2514 hub.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-udoo.dts | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-udoo.dts b/arch/arm/boot/dts/imx6q-udoo.dts
> index 1c7f7a1..109b997 100644
> --- a/arch/arm/boot/dts/imx6q-udoo.dts
> +++ b/arch/arm/boot/dts/imx6q-udoo.dts
> @@ -19,6 +19,23 @@
>  	memory {
>  		reg = <0x10000000 0x40000000>;
>  	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +

This should have a ranges property, or it's not a simple-bus.

Why do you even need this anyway? The regulators can live under the root
quite happily.

Thanks,
Mark.

From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 19 Feb 2018 13:06:24 +0100
Subject: [RFC] ARM: dts: imx28-tx28: Pass the memory unit name
In-Reply-To: <1518882103-17137-1-git-send-email-festevam@gmail.com>
References: <1518882103-17137-1-git-send-email-festevam@gmail.com>
Message-ID: <20180219130624.30a5f572@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 17 Feb 2018 13:41:43 -0200 Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Pass the memory unit name in order to fix the following
> dtc warning with W=1:
> 
> arch/arm/boot/dts/imx28-tx28.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Hi,
> 
> Currently the only dtc warnings observed with W=1 are the ones:
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> 
> If this solution can be accepted I can clean all the other i.MX dts files.
> 
> Please advise.
> 
>  arch/arm/boot/dts/imx28-tx28.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> index 8a4f5bc..bbdf004 100644
> --- a/arch/arm/boot/dts/imx28-tx28.dts
> +++ b/arch/arm/boot/dts/imx28-tx28.dts
> @@ -65,8 +65,8 @@
>  		usbotg = &usb0;
>  	};
>  
> -	memory {
> -		reg = <0 0>; /* will be filled in by U-Boot */
> +	memory at 40000000 {
> +		reg = <0x40000000 0>; /* will be filled in by U-Boot */
>  	};
>  
>  	onewire {
>
I have no objections to this change. U-Boot still finds the memory node
and puts the correct size into the 'reg' property.

Acked-by: Lothar Wa?mann <LW@KARO-electronics.de>


Lothar Wa?mann

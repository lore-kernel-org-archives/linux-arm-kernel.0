From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 26 Sep 2013 13:36:10 +0200
Subject: [PATCH 3/3] ARM: mxs: dts: Enable DCP for MXS
In-Reply-To: <1380194306-5243-3-git-send-email-marex@denx.de>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <1380194306-5243-3-git-send-email-marex@denx.de>
Message-ID: <21060.7210.127710.800708@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marek Vasut writes:
> Enable the DCP by default on both i.MX23 and i.MX28.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> To: linux-crypto at vger.kernel.org
> ---
>  arch/arm/boot/dts/imx23.dtsi | 4 +++-
>  arch/arm/boot/dts/imx28.dtsi | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 87faa6e..0630a9a 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -337,8 +337,10 @@
>  			};
>  
>  			dcp at 80028000 {
> +				compatible = "fsl,mxs-dcp";
>  				reg = <0x80028000 0x2000>;
> -				status = "disabled";
> +				interrupts = <53 54>;
> +				status = "okay";
>  			};
AFAICT the policy seems to be that nodes, that are always enabled
don't get a 'status' property at all.

>  			pxp at 8002a000 {
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 918d419..8b5ad60 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -782,9 +782,10 @@
>  			};
>  
>  			dcp: dcp at 80028000 {
> +				compatible = "fsl,mxs-dcp";
>  				reg = <0x80028000 0x2000>;
> -				interrupts = <52 53 54>;
> -				compatible = "fsl-dcp";
>
What about drivers/crypto/dcp.c that is currently using this property?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

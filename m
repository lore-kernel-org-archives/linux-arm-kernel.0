From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 23 Jun 2013 21:04:48 +0200
Subject: [PATCH 1/6] ARM: dts: imx27: Add SAHARA2 devicetree node
In-Reply-To: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
References: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
Message-ID: <20130623190448.GB26397@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 10:54:45AM +0400, Alexander Shiyan wrote:
> From: Alexander Shiyan <shc_work@mail.ru>
> 
> This patch adds the missing (Symmetric/Asymmetric Hashing and Random
> Accelerator) SAHARA2 devicetree node for i.MX27 CPUs.
> 
> Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 0695264..04f9154 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -351,6 +351,14 @@
>  				iram = <&iram>;
>  			};
>  
> +			sahara2: sahara at 10025000 {
> +				compatible = "fsl,imx27-sahara";
> +				reg = <0x10025000 0x0800>;

I think we should use the whole register space here which would be
0x1000.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

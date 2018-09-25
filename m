From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Sep 2018 23:07:29 +0800
Subject: [PATCH 2/6] ARM: dts: imx51-zii-scu3-esb: Disable VPU
In-Reply-To: <1536696647-8228-2-git-send-email-festevam@gmail.com>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
 <1536696647-8228-2-git-send-email-festevam@gmail.com>
Message-ID: <20180925150727.GD21282@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 05:10:43PM -0300, Fabio Estevam wrote:
> imx51-zii-scu3-esb does not have any video encoding/decoding needs,
> so disable the VPU.

@Andrey, do you agree?

Shawn

> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
> index e6ebac8..14b2077 100644
> --- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
> +++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
> @@ -350,6 +350,10 @@
>  	vcc-supply = <&vusb2_reg>;
>  };
>  
> +&vpu {
> +	status = "disabled";
> +};
> +
>  &wdog1 {
>  	status = "disabled";
>  };
> -- 
> 2.7.4
> 

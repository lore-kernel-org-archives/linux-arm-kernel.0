From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 10:07:46 +0800
Subject: [PATCH v2] ARM: dts: vf610-colibri: Add ADC support
In-Reply-To: <a0ecfce3f97fb6684657ae76b89f38108fcdf68f.1411122224.git.maitysanchayan@gmail.com>
References: <cover.1411122224.git.maitysanchayan@gmail.com>
 <a0ecfce3f97fb6684657ae76b89f38108fcdf68f.1411122224.git.maitysanchayan@gmail.com>
Message-ID: <20140926020745.GH21077@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 04:56:13PM +0530, Sanchayan Maity wrote:
> Enable ADC support for Colibri VF61 modules
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vf610-colibri.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
> index 0cd8343..6fd099e 100644
> --- a/arch/arm/boot/dts/vf610-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf610-colibri.dtsi
> @@ -27,6 +27,16 @@
>  
>  };
>  
> +&adc0 {
> +	pinctrl-names = "default";

Sorry for missing it, but I would expect properties pinctrl-names and
pinctrl-0 appear as a couple.  Should we drop property pinctrl-names
here?

Shawn

> +	status = "okay";
> +};
> +
> +&adc1 {
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
> -- 
> 1.7.9.5
> 

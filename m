From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 28 Mar 2017 21:33:04 -0700
Subject: [PATCH v2 3/8] ARM: OMAP5: Thermal: Add slope and offset values
In-Reply-To: <1489046762-11288-4-git-send-email-j-keerthy@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
 <1489046762-11288-4-git-send-email-j-keerthy@ti.com>
Message-ID: <20170329043302.GA1596@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 01:35:57PM +0530, Keerthy wrote:
> Currently the slope and offset values for calculating the
> hot spot temperature of a particular thermal zone is part
> of driver data. Pass them here instead and obtain the values
> while of node parsing.


The patch is fine.. but

> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 222155c..eaff2a5 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -1127,6 +1127,15 @@
>  
>  &cpu_thermal {
>  	polling-delay = <500>; /* milliseconds */
> +	coefficients = <65 (-1791)>;

I suppose you tried this change with this patch:
https://patchwork.kernel.org/patch/9619577/
?

Otherwise, I do not see how your coeff would work, right?

>  };
>  
>  /include/ "omap54xx-clocks.dtsi"
> +
> +&gpu_thermal {
> +	coefficients = <117 (-2992)>;
> +};
> +
> +&core_thermal {
> +	coefficients = <0 2000>;
> +};
> -- 
> 1.9.1
> 

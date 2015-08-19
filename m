From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 19 Aug 2015 09:36:28 -0700
Subject: [PATCH v4 2/3] ARM: qcom: add SMEM device node to IPQ806x dts
In-Reply-To: <1439931860-7473-3-git-send-email-mathieu@codeaurora.org>
References: <1439931860-7473-1-git-send-email-mathieu@codeaurora.org>
 <1439931860-7473-3-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150819163628.GY13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 18 Aug 14:04 PDT 2015, Mathieu Olivari wrote:

> SMEM is used on IPQ806x to store various board related information such
> as boot device and flash partition layout. We'll declare it as a device
> so we can make use of it thanks to the new SMEM soc driver.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
> ---
> 
> Notes:
>     v2:
>     *Rename "smem" tag into "smem_region"
> 
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 8d366ae..9834c94 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -55,7 +55,7 @@
>  			no-map;
>  		};
>  
> -		smem at 41000000 {
> +		smem_region: smem at 41000000 {
>  			reg = <0x41000000 0x200000>;
>  			no-map;
>  		};
> @@ -341,4 +341,10 @@
>  
>  		#hwlock-cells = <1>;
>  	};
> +
> +	smem {
> +		compatible = "qcom,smem";
> +		memory-region = <&smem_region>;
> +		hwlocks = <&sfpb_mutex 3>;
> +	};
>  };
> -- 
> 2.1.4
> 

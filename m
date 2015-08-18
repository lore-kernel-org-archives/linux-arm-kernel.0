From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 18 Aug 2015 11:11:38 -0700
Subject: [PATCH v3 2/3] ARM: qcom: add SMEM device node to IPQ806x dts
In-Reply-To: <1439855266-26242-3-git-send-email-mathieu@codeaurora.org>
References: <1439855266-26242-1-git-send-email-mathieu@codeaurora.org>
 <1439855266-26242-3-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150818181138.GV13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 17 Aug 16:47 PDT 2015, Mathieu Olivari wrote:

> SMEM is used on IPQ806x to store various board related information such
> as boot device and flash partition layout. We'll declare it as a device
> so we can make use of it thanks to the new SMEM soc driver.
> 
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 8d366ae..85dbccf 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -55,7 +55,7 @@
>  			no-map;
>  		};
>  
> -		smem at 41000000 {
> +		smem: smem at 41000000 {

I would preferred if you used a name like "smem_region", although I
don't think we will use the phandle name "smem" for anything else...

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
> +		memory-region = <&smem>;
> +		hwlocks = <&sfpb_mutex 3>;
> +	};
>  };

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn

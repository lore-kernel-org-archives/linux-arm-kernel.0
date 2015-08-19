From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 19 Aug 2015 09:35:48 -0700
Subject: [PATCH v4 1/3] ARM: qcom: add SFPB nodes to IPQ806x dts
In-Reply-To: <1439931860-7473-2-git-send-email-mathieu@codeaurora.org>
References: <1439931860-7473-1-git-send-email-mathieu@codeaurora.org>
 <1439931860-7473-2-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150819163548.GX13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 18 Aug 14:04 PDT 2015, Mathieu Olivari wrote:

> Add one new node to the ipq806x.dtsi file to declare & register the
> hardware spinlock devices. This mechanism is required to be used by
> other drivers such as SMEM.
> 

Still looks good, but you should have added:

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 9f727d8..8d366ae 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -329,5 +329,16 @@
>  			#reset-cells = <1>;
>  		};
>  
> +		sfpb_mutex_block: syscon at 1200600 {
> +			compatible = "syscon";
> +			reg = <0x01200600 0x100>;
> +		};
> +	};
> +
> +	sfpb_mutex: sfpb-mutex {
> +		compatible = "qcom,sfpb-mutex";
> +		syscon = <&sfpb_mutex_block 4 4>;
> +
> +		#hwlock-cells = <1>;
>  	};
>  };
> -- 
> 2.1.4
> 

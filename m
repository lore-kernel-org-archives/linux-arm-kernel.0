From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 18 Aug 2015 10:59:21 -0700
Subject: [PATCH v3 1/3] ARM: qcom: add SFPB nodes to IPQ806x dts
In-Reply-To: <1439855266-26242-2-git-send-email-mathieu@codeaurora.org>
References: <1439855266-26242-1-git-send-email-mathieu@codeaurora.org>
 <1439855266-26242-2-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150818175921.GT13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 17 Aug 16:47 PDT 2015, Mathieu Olivari wrote:

> Add one new node to the ipq806x.dtsi file to declare & register the
> hardware spinlock devices. This mechanism is required to be used by
> other drivers such as SMEM.
> 

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

I have this block listed to start at 0x1200000 and used 0x604 as offset
when testing this. In my docs there's nothing in those first 0x600 bytes
though, so this works fine for me.

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

Regards,
Bjorn

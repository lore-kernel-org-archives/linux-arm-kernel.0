From: jmcnicol@redhat.com (Jeremy McNicoll)
Date: Thu, 11 Jan 2018 18:33:55 -0800
Subject: [PATCH] arm64: dts: angler: add pstore-ramoops support
In-Reply-To: <1514446709-19347-1-git-send-email-zhuoweizhang@yahoo.com>
References: <1514446709-19347-1-git-send-email-zhuoweizhang@yahoo.com>
Message-ID: <20180112023354.GA16005@mini-rhel.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 02:38:29AM -0500, zhuoweizhang at yahoo.com wrote:
> From: Zhuowei Zhang <zhuoweizhang@yahoo.com>
> 
> Support pstore-ramoops for retrieving kernel oops and panics after reboot.
> 
> The address and configs are taken from the downstream kernel's device tree.
> 
> Signed-off-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
> index dfa08f5..9ce3a6e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
> @@ -37,4 +37,19 @@
>  			pinctrl-1 = <&blsp1_uart2_sleep>;
>  		};
>  	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ramoops at 1fe00000 {
> +			compatible = "ramoops";
> +			reg = <0 0x1fe00000 0 0x00200000>;

Downstream doesn't use 0x0 to denote 0.  I am fine with this, if 
someone has a concern or issue with it we can change it before merging.


> +			console-size = <0x100000>;
> +			record-size = <0x10000>;
> +			ftrace-size = <0x10000>;
> +			pmsg-size = <0x80000>;

We could pad this with leading 0's but I find this much easier
to read.

> +		};
> +	};
>  };

Thank you very much for taking the time to send this.  


Acked-by: Jeremy McNicoll <jeremymc@redhat.com>

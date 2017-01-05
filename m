From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 5 Jan 2017 07:42:02 -0800
Subject: [PATCH] arm64: dts: msm8996: Add required memory carveouts
In-Reply-To: <1482357822-20823-1-git-send-email-andy.gross@linaro.org>
References: <1482357822-20823-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20170105154202.GA8599@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 21 Dec 14:03 PST 2016, Andy Gross wrote:

> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> This patch adds required memory carveouts so that the kernel does not
> access memory that is in use or has been reserved for use by other remote
> processors.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index cde4114..25e11dc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -64,6 +64,16 @@
>  			reg = <0x0 0x86000000 0x0 0x200000>;
>  			no-map;
>  		};
> +
> +		memory at 85800000 {
> +			reg = <0x0 0x85800000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		memory at 86200000 {
> +			reg = <0x0 0x86200000 0x0 0x2600000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

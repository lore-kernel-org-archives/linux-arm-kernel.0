From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 13:23:44 -0600
Subject: [PATCH 4/4] arm: dts: apq8064: add shared memory node
In-Reply-To: <1449858789-13605-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1449858789-13605-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20151211192344.GA4022@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 06:33:09PM +0000, Srinivas Kandagatla wrote:
> This patch adds support to qcom,smem device.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 829028a..40dd6b4 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -682,5 +682,11 @@
>  			#hwlock-cells = <1>;
>  		};
>  
> +		smem {
> +			compatible = "qcom,smem";
> +			memory-region = <&smem>;
> +			hwlocks = <&sfpb_mutex 3>;
> +		};
> +

smem needs to be outside the soc as there is no reg entry.

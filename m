From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 Mar 2016 23:25:38 +0300
Subject: [PATCH v2 3/3] ARM: dts: apq8064: add ahci ports-implemented mask
In-Reply-To: <1459445500-9071-4-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459445500-9071-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459445500-9071-4-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <56FD87C2.3020503@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 08:31 PM, Srinivas Kandagatla wrote:

> This patch adds new ports-implemented mask, which is required to get
> achi working on the mainline. Without this patch value read from
> PORTS_IMPL register which is zero would not enable any ports for
> software to use.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   arch/arm/boot/dts/qcom-apq8064.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 252b310..71d6fcb 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -696,7 +696,7 @@
>   		};
>
>   		sata0: sata at 29000000 {
> -			compatible		= "generic-ahci";
> +			compatible		= "generic-ahci", "qcom,apq8064-ahci";

    The order of values should be reverse, no?

[...]

MBR, Sergei

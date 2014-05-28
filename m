From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 28 May 2014 15:09:49 -0500
Subject: [PATCH] ARM: dts: qcom: Update msm8960 device trees
In-Reply-To: <1401301643-20191-1-git-send-email-galak@codeaurora.org>
References: <1401301643-20191-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140528200948.GI2012@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 01:27:23PM -0500, Kumar Gala wrote:
> * Move SoC peripherals into an SoC container node
> * Move serial enabling into board file (qcom-msm8960-cdp.dts)
> * Cleanup cpu node to match binding spec, enable-method and compatible
>   should be per cpu, not part of the container
> * Drop interrupts property from l2-cache node as its not part of the
>   binding spec
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-msm8960-cdp.dts |   6 ++
>  arch/arm/boot/dts/qcom-msm8960.dtsi    | 165 +++++++++++++++++----------------
>  2 files changed, 93 insertions(+), 78 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> index a58fb88..8e77ed7 100644
> --- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> +++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> @@ -3,4 +3,10 @@
>  / {
>  	model = "Qualcomm MSM8960 CDP";
>  	compatible = "qcom,msm8960-cdp", "qcom,msm8960";
> +
> +	soc {
> +		serial at 16440000 {
> +			status = "ok";
> +		};
> +	};
>  };

Is now the time put these serial nodes under a GSBI parent node?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 4 Feb 2014 15:09:56 -0800
Subject: [PATCH v2 2/5] clocksource: qcom: Move clocksource code out of
 mach-msm
In-Reply-To: <1391553532-27001-3-git-send-email-galak@codeaurora.org>
References: <1391553532-27001-1-git-send-email-galak@codeaurora.org>
 <1391553532-27001-3-git-send-email-galak@codeaurora.org>
Message-ID: <20140204230956.GE20528@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04, Kumar Gala wrote:
> We intent to share the clocksource code for MSM platforms between legacy

s/intent/intend/

> and multiplatform supported qcom SoCs.
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cd6950f..81caa16 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -140,3 +140,7 @@ config VF_PIT_TIMER
>  	bool
>  	help
>  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
> +
> +config CLKSRC_QCOM
> +	bool
> +	depends on ARCH_MSM

It would be a a little less noisy if  you left this as MSM_TIMER
(msm is all over the code in that file anyway). Also, why do we
care about depending on ARCH_MSM here? This is a hidden Kconfig
option anyway.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

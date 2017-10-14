From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sat, 14 Oct 2017 00:31:18 -0700
Subject: [PATCH v2 4/4] mmc: sdhci-msm: Add sdhci msm register write APIs
 which wait for pwr irq
In-Reply-To: <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
Message-ID: <20171014073118.GD1575@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 26 Sep 22:34 PDT 2017, Vijay Viswanath wrote:

> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
[..]
> +	if (!done) {
> +		if (!wait_event_timeout(msm_host->pwr_irq_wait,
> +				msm_host->pwr_irq_flag,
> +				msecs_to_jiffies(MSM_PWR_IRQ_TIMEOUT_MS)))
> +			__WARN_printf("%s: pwr_irq for req: (%d) timed out\n",
> +					mmc_hostname(host->mmc), req_type);

Bumped my MSM8974AB device to latest linux-next and found this patch; I
see this print every five seconds during boot and the eMMC never comes
up.

Regards,
Bjorn

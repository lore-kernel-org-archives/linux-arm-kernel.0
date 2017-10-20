From: vviswana@codeaurora.org (Vijay Viswanath)
Date: Fri, 20 Oct 2017 16:24:39 +0530
Subject: [PATCH v2 4/4] mmc: sdhci-msm: Add sdhci msm register write APIs
 which wait for pwr irq
In-Reply-To: <20171014073118.GD1575@tuxbook>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
 <20171014073118.GD1575@tuxbook>
Message-ID: <cf405901-e711-4ef9-dffd-1e94a023c4a1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2017 1:01 PM, Bjorn Andersson wrote:
> On Tue 26 Sep 22:34 PDT 2017, Vijay Viswanath wrote:
> 
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> [..]
>> +	if (!done) {
>> +		if (!wait_event_timeout(msm_host->pwr_irq_wait,
>> +				msm_host->pwr_irq_flag,
>> +				msecs_to_jiffies(MSM_PWR_IRQ_TIMEOUT_MS)))
>> +			__WARN_printf("%s: pwr_irq for req: (%d) timed out\n",
>> +					mmc_hostname(host->mmc), req_type);
> 
> Bumped my MSM8974AB device to latest linux-next and found this patch; I
> see this print every five seconds during boot and the eMMC never comes
> up.
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi Bjorn,

I couldn't get one 8974 device. I tested the latest linux-next on db410c 
and its not showing any issue. 8974 is an older msm and has some 
differences in the controller like your "mmc: sdhci-msm: Enable delay 
circuit calibration clocks" patch.

I am currently going through the programming guide to see what could be 
the reason. Can you please share the full logs from the device with me 
so that I can focus my search?

Thanks,
Vijay

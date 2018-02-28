From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 28 Feb 2018 11:04:26 +0530
Subject: [PATCH v8 14/15] cpufreq: Add module to register cpufreq on Krait
 CPUs
In-Reply-To: <87zi3ujx7c.fsf@bootlin.com>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
 <1519740422-3835-15-git-send-email-sricharan@codeaurora.org>
 <87zi3ujx7c.fsf@bootlin.com>
Message-ID: <95e134a6-7992-e16f-dc55-df7af96b31b9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 2/27/2018 8:28 PM, Gregory CLEMENT wrote:
> Hi Sricharan,
>  
>  On mar., f?vr. 27 2018, Sricharan R <sricharan@codeaurora.org> wrote:
> 
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> Register a cpufreq-generic device whenever we detect that a
>> "qcom,krait" compatible CPU is present in DT.
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> [Sricharan: updated to use dev_pm_opp_set_prop_name and
>> 	    nvmem apis]
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm          |  10 ++
>>  drivers/cpufreq/Makefile             |   3 +
>>  drivers/cpufreq/cpufreq-dt-platdev.c |   5 +
>>  drivers/cpufreq/qcom-cpufreq.c       | 183 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 201 insertions(+)
>>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 3a88e33..826f9e7 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -133,6 +133,16 @@ config ARM_OMAP2PLUS_CPUFREQ
>>  	depends on ARCH_OMAP2PLUS
>>  	default ARCH_OMAP2PLUS
>>  
>> +config ARM_QCOM_CPUFREQ
>> +	bool "CPUfreq driver for the QCOM SoCs with KRAIT processors"
>> +	depends on ARCH_QCOM
>> +	select PM_OPP
>> +	help
>> +	  This enables the CPUFreq driver for Qualcomm SoCs with
>> +	  KRAIT processors.
>> +
>> +	  If in doubt, say N.
>> +
>>  config ARM_S3C_CPUFREQ
>>  	bool
>>  	help
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index c60c1e1..21894f6 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -65,6 +65,9 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>>  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
>> +obj-$(CONFIG_ARM_QCOM_CPUFREQ)		+= qcom-cpufreq.o
> 
> These 2 following lines don't seem related to the commit log:
>> +obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
>> +obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
> 

 oops. Will remove. Rebase mistake. Thanks.

Regards,
 Sricharan-- 

"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

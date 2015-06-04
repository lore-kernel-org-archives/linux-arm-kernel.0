From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 4 Jun 2015 10:49:14 -0600
Subject: [GIT PULL] qcom SoC changes for 4.2-1
In-Reply-To: <20150601191352.GI32700@linaro.org>
References: <alpine.DEB.2.02.1505261449220.26936@galak-ubuntu.qualcomm.com>
 <alpine.DEB.2.02.1505281055020.17861@galak-ubuntu.qualcomm.com>
 <2248044.jBzoST62A5@wuerfel> <3126465.IVbQcV0VyT@wuerfel>
 <289B1418-D152-4456-8492-5A106363D92E@codeaurora.org>
 <20150601191352.GI32700@linaro.org>
Message-ID: <20150604164914.GT32700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01 2015 at 13:13 -0600, Lina Iyer wrote:
>On Mon, Jun 01 2015 at 13:04 -0600, Kumar Gala wrote:
>>
>>>On Jun 1, 2015, at 1:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>>On Friday 29 May 2015 14:42:01 Arnd Bergmann wrote:
>>>>On Thursday 28 May 2015 10:55:39 Kumar Gala wrote:
>>>>>Qualcomm ARM Based SoC Updates for v4.2-1
>>>>>
>>>>>* Added Subsystem Power Manager (SPM) driver
>>>>>* Split out 32-bit specific SCM code
>>>>>* Added HDCP SCM call
>>>>>
>>>>>
>>>>
>>>>Pulled into next/drivers, thanks!
>>>>
>>>
>>>I've had to apply this patch on top of our for-next branch to make it
>>>build for randconfig.
>>>
>>>Can you check that this makes sense?
>>>
>>>	Arnd
>>
>>The QCOM_SCM makes sense, Lina can comment on the ARM_CPU_SUSPEND bit, but seems reasonable to me.
>>
>Make sense to have both the selects below.
>
>I will test it and report.
>
I dont see a problem with these changes.

>Thanks,
>Lina
>
>>- k
>>
>>>
>>>diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>index 5eea374c8fa6..01aa2fd3514d 100644
>>>--- a/drivers/soc/qcom/Kconfig
>>>+++ b/drivers/soc/qcom/Kconfig
>>>@@ -13,6 +13,8 @@ config QCOM_GSBI
>>>config QCOM_PM
>>>	bool "Qualcomm Power Management"
>>>	depends on ARCH_QCOM && !ARM64
>>>+	select QCOM_SCM
>>>+	select ARM_CPU_SUSPEND
>>>	help
>>>	  QCOM Platform specific power driver to manage cores and L2 low power
>>>	  modes. It interface with various system drivers to put the cores in
>>>
>>>--
>>>To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>>>the body of a message to majordomo at vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>-- 
>>Qualcomm Innovation Center, Inc.
>>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>>a Linux Foundation Collaborative Project
>>

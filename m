From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 13 Oct 2015 09:51:50 -0700
Subject: [PATCH 09/10] clk: ns2: add clock support for Broadcom Northstar
 2 SoC
In-Reply-To: <20151012181929.GG20867@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-10-git-send-email-jonmason@broadcom.com>
 <20151010003352.GA26883@codeaurora.org> <20151012181929.GG20867@broadcom.com>
Message-ID: <561D36A6.2080309@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

Comment below.

On 15-10-12 11:19 AM, Jon Mason wrote:
> On Fri, Oct 09, 2015 at 05:33:52PM -0700, Stephen Boyd wrote:
>> On 10/02, Jon Mason wrote:
>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>> index 23800a1..2790f21 100644
>>> --- a/arch/arm64/Kconfig.platforms
>>> +++ b/arch/arm64/Kconfig.platforms
>>> @@ -2,6 +2,7 @@ menu "Platform selection"
>>>
>>>   config ARCH_BCM_IPROC
>>>   	bool "Broadcom iProc SoC Family"
>>> +	select COMMON_CLK_IPROC
>>
>> Given that this is a visible option, I'd expect the defconfig to
>> enable this.
>
> After looking at this again, it is completely unnecessary.  Removed.
>
>>
>>>   	help
>>>   	  This enables support for Broadcom iProc based SoCs
>>>
>>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>>> index d08b3e5..ea81eaa 100644
>>> --- a/drivers/clk/Makefile
>>> +++ b/drivers/clk/Makefile
>>> @@ -47,7 +47,8 @@ obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
>>>   obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
>>>   obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
>>>   obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
>>> -obj-$(CONFIG_ARCH_BCM)			+= bcm/
>>> +obj-$(CONFIG_CLK_BCM_KONA)		+= bcm/
>>> +obj-$(CONFIG_COMMON_CLK_IPROC)		+= bcm/
>>
>> Also, perhaps we need some sort of Kconfig thing for overall bcm
>> clock drivers, so that we don't have duplicate Makefile rules.
>>
>> 	config COMMON_CLK_BCM
>> 		bool "Support for Broadcom clocks"
>
> Will do.

Is that really necessary at all  I think something like this work instead?

-obj-$(CONFIG_ARCH_BCM)			+= bcm/
+obj-y		+= bcm/



>
> Thanks,
> Jon
>
>
>>
>> --
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project

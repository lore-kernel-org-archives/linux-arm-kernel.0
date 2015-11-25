From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 12:39:30 -0800
Subject: [PATCH 3/3] ARM: qcom: Drop ARCH_MSM* configs
In-Reply-To: <5774027.3ZvxSC0ub5@wuerfel>
References: <1448413710-8101-1-git-send-email-sboyd@codeaurora.org>
 <3990433.OKhWpPeunI@wuerfel> <20151125193447.GD11298@codeaurora.org>
 <5774027.3ZvxSC0ub5@wuerfel>
Message-ID: <56561C82.9070103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/15 12:30, Arnd Bergmann wrote:
> On Wednesday 25 November 2015 11:34:47 Stephen Boyd wrote:
>> On 11/25, Arnd Bergmann wrote:
>>> On Wednesday 25 November 2015 13:27:55 Daniel Lezcano wrote:
>>>> What about:
>>>>
>>>> textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
>>>> textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
>>>>
>>>> in arch/arm/Makefile
>>> Good point, we need to do something about these still.
>>>
>> Yeah good catch! My brain must be shutting down due to the
>> holiday coming up.
>>
>> The nice thing is that CLKSRC_QCOM and this text offset stuff are
>> always used on the same SoCs, so we should be able to make one
>> config in mach-qcom/Kconfig that selects the qcom clksrc driver
>> and adjusts the text offset. So is the suggestion to move
>> CLKSRC_QCOM to mach-qcom/Kconfig, or to make a new config that
>> selects it?
> I was thinking of a new option that selects it, which I think is
> more in line with what Daniel wants.
>
>

Ok. Sounds good. Patch will follow soon after I boot test on all the
affected devices.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Oct 2011 07:22:15 -0500
Subject: [PATCH 1/2] ARM: Samsung: Add Exynos4 device tree enabled board
	file
In-Reply-To: <000201cc8a64$6775ae30$36610a90$%kim@samsung.com>
References: <1318342396-26178-1-git-send-email-thomas.abraham@linaro.org>
	<1318342396-26178-2-git-send-email-thomas.abraham@linaro.org>
	<20111013175110.GJ18574@ponder.secretlab.ca>
	<000201cc8a64$6775ae30$36610a90$%kim@samsung.com>
Message-ID: <4E982977.7000305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2011 06:28 AM, Kukjin Kim wrote:


>>> diff --git a/arch/arm/mach-exynos4/Kconfig
> b/arch/arm/mach-exynos4/Kconfig
>>> index 0c5888a..39dc135 100644
>>> --- a/arch/arm/mach-exynos4/Kconfig
>>> +++ b/arch/arm/mach-exynos4/Kconfig
>>> @@ -304,6 +304,20 @@ config MACH_SMDK4412
>>>  	help
>>>  	  Machine support for Samsung SMDK4412
>>>
>>> +comment "Flattened Device Tree based board for Exynos4 based SoC"
>>> +
>>> +config MACH_EXYNOS4_DT
> 
> I'm not sure we can use 'MACH_EXYNOS4_DT' here because there are other
> EXYNOS4 SoCs such as EXYNOS4212 and EXYNOS4412. So if this cannot support
> other SoCs' boards, SMDK4212 and SMDK4412, we need to change the name.
> 
> And I wonder whether there is no problem with selecting this and other
> boards.

I think this should be fine assuming most things are common. Generally,
the differences can be handled by different DT's. The board compatible
string can be used to handle differences.

Rob

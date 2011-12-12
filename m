From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Dec 2011 09:31:52 -0600
Subject: [PATCH] ARM: pl2x0/pl310: Refactor Kconfig to be more maintainable
In-Reply-To: <20111212151404.GC2296@linaro.org>
References: <1322584345-19193-1-git-send-email-dave.martin@linaro.org>
 <4ED531C3.8050004@gmail.com> <20111212151404.GC2296@linaro.org>
Message-ID: <4EE61E68.9050807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2011 09:14 AM, Dave Martin wrote:
> On Tue, Nov 29, 2011 at 01:25:55PM -0600, Rob Herring wrote:
>> On 11/29/2011 10:32 AM, Dave Martin wrote:

[snip]

>>>  config CACHE_L2X0
>>>  	bool "Enable the L2x0 outer cache controller"
>>> -	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
>>> -		   REALVIEW_EB_A9MP || ARCH_IMX_V6_V7 || MACH_REALVIEW_PBX || \
>>> -		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
>>> -		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
>>> -		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX || ARCH_HIGHBANK
>>> +	depends on HAVE_L2X0_L2CC
>>
>> For platforms that run in non-secure mode, this shouldn't really be a
>> user selectable option. Perhaps those should just select CACHE_L2X0
>> directly. I'm not sure which one's those are other than Highbank and OMAP4.
> 
> Highbank doesn't currently have this.  Should I add this, or should we
> leave that for a separate patch?
> 
> Arguably, a refactoring patch shouldn't change the Kconfig behaviour --
> possibly anything which is currently broken should stay broken (but can
> be fixed later).

I thinking highbank wouldn't need HAVE_L2X0_L2CC, but it does to satisfy
dependencies. So you're right, it should probably be separate.

Rob

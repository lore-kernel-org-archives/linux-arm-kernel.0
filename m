From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 5 Mar 2015 08:03:01 -0800
Subject: [PATCH v2 2/3] arm64: qcom: Add support for Qualcomm MSM8916 SoC
In-Reply-To: <63B0478A-6282-4826-8991-46B0E4BA7BA5@codeaurora.org>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <1425503602-24916-2-git-send-email-galak@codeaurora.org>
 <54F7883B.90704@codeaurora.org>
 <63B0478A-6282-4826-8991-46B0E4BA7BA5@codeaurora.org>
Message-ID: <20150305160301.GA29444@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05, Kumar Gala wrote:
> 
> On Mar 4, 2015, at 4:33 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > On 03/04/15 13:13, Kumar Gala wrote:
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 1b8e973..4c8b119 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -177,6 +177,15 @@ config ARCH_MEDIATEK
> >> 	help
> >> 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
> >> 
> >> +config ARCH_QCOM
> >> +	bool "Qualcomm Platforms"
> >> +	select ARCH_REQUIRE_GPIOLIB
> >> +	select COMMON_CLK_QCOM
> >> +	select PINCTRL
> >> +	select SOC_BUS
> > 
> > I imagine all we need is select PINCTRL here. SOC_BUS is not used, also
> > we shouldn't force COMMON_CLK_QCOM to be Y instead of M so please drop
> > that select. Also we dropped ARCH_REQUIRE_GPIOLIB in arm32 so it would
> > match if we just relied on ARCH_WANT_GPIOLIB that arm64 has by default
> 
> Will drop SOC_BUS.  We seem to have other arm64 platforms that set ARCH_REQUIRE_GPIOLIB.  Why should we not select COMMON_CLK_QCOM?  Can we do much useful without COMMON_CLK_QCOM set?
> 

For gpiolib I was trying to say that it would match what we did
for ARCH_QCOM on arm32. The same is true for COMMON_CLK_QCOM.

We don't select these configs because they aren't required to
boot into a ramdisk that contains the clock driver and gpiolib
framework plus whatever disk driver and filesystem we may need to
access the (presumably) much larger disk that contains the rest
of the modules.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

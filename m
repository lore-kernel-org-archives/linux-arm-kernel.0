From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 11:34:47 -0800
Subject: [PATCH 3/3] ARM: qcom: Drop ARCH_MSM* configs
In-Reply-To: <3990433.OKhWpPeunI@wuerfel>
References: <1448413710-8101-1-git-send-email-sboyd@codeaurora.org>
 <1448413710-8101-4-git-send-email-sboyd@codeaurora.org>
 <5655A94B.3030304@linaro.org> <3990433.OKhWpPeunI@wuerfel>
Message-ID: <20151125193447.GD11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25, Arnd Bergmann wrote:
> On Wednesday 25 November 2015 13:27:55 Daniel Lezcano wrote:
> > 
> > What about:
> > 
> > textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> > textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> > 
> > in arch/arm/Makefile
> 
> Good point, we need to do something about these still.
> 

Yeah good catch! My brain must be shutting down due to the
holiday coming up.

The nice thing is that CLKSRC_QCOM and this text offset stuff are
always used on the same SoCs, so we should be able to make one
config in mach-qcom/Kconfig that selects the qcom clksrc driver
and adjusts the text offset. So is the suggestion to move
CLKSRC_QCOM to mach-qcom/Kconfig, or to make a new config that
selects it?

> > and
> > 
> > CONFIG_ARCH_MSM8X60=y
> > CONFIG_ARCH_MSM8960=y
> > CONFIG_ARCH_MSM8974=y
> > 
> > in arch/arm/configs/qcom_defconfig and multi_v7_defconfig
> > 
> > ?
> 
> These should be removed, but they are harmless.

Yes I was planning to let those fall out of some defconfig update
patch later on.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

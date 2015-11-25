From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 11:17:17 +0100
Subject: [PATCH 1/3] clocksource: defbool CLKSRC_QCOM=y on ARCH_QCOM and
 make it visible
In-Reply-To: <56558929.6090403@linaro.org>
References: <1448413710-8101-1-git-send-email-sboyd@codeaurora.org>
 <1448413710-8101-2-git-send-email-sboyd@codeaurora.org>
 <56558929.6090403@linaro.org>
Message-ID: <3550727.W9y7mWx54D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 11:10:49 Daniel Lezcano wrote:
> On 11/25/2015 02:08 AM, Stephen Boyd wrote:
> > We want to remove the ARCH_MSM* configs in mach-qcom/Kconfig
> > because they are mostly proxy configs for selecting the right
> > clocksource driver. Therefore, make CLKSRC_QCOM default to the
> > value of ARCH_QCOM, but also make it visible if ARCH_QCOM=y so
> > that we can turn it off when we don't want it.
> 
> I have been removing the ARCH dependencies in the Kconfig file.
> 
> Why do you have to turn it off manually ?

The background is that this is used only on some of the older
MSM SoCs, while the newer ones use the arch timer.

We decided to remove the SoC-specific top-level options from
mach-msm as they are becoming rather meaningless these days
and just a burden to maintain at the rate that new variants
get released, so being able to turn off this driver helps make
the kernel slightly smaller if you are building a kernel for
only the more recent models.

	Arnd

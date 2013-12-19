From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 19 Dec 2013 14:45:20 -0800
Subject: [GIT PULL] Support for efm32
In-Reply-To: <20131216190953.GB14866@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
 =?utf-8?Q?e-K=C3=B6nig=22's?=
 message of "Mon, 16 Dec 2013 20:09:53 +0100")
References: <20131216190953.GB14866@pengutronix.de>
Message-ID: <87d2ksjw8v.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:
>
>   Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)
>
> are available in the git repository at:
>
>   git://git.pengutronix.de/git/ukl/linux.git tags/efm32
>
> for you to fetch changes up to ef43eff3447f30b4a3cfc61813902c2e57c20245:
>
>   ARM: device trees for Energy Micro's EFM32 Cortex-M3 SoCs (2013-12-16 17:51:34 +0100)
>
> ----------------------------------------------------------------
> These two commits add preliminary support for Energy Micro (now Silicon Labs)
> Giant Gecko SoCs. They have a Cortex-M3 core, and so are Thumb2 only and don't
> feature an MMU. With these changes merged there is no additional code needed
> under arch/arm to run Linux on such a SoC.
> ----------------------------------------------------------------
>
> Compared to the patch sent a few days ago (v5, Message-Id:
> 1386694516-5876-1-git-send-email-u.kleine-koenig at pengutronix.de), I let
> ARCH_EFM32 temporarily select CLKSRC_MMIO until 4ff3774 (clocksource:
> time-efm32: Select CLKSRC_MMIO) hits mainline. 

OK.

> Also I just noticed that
> the clk support got in v3.13-rc1, so the device tree is buildable now.
> This patch adding the device tree sources wasn't sent yet in it's
> current form, so I will send it as reply to this mail. I hope it's not
> controversal, so the two patches can go in together.

Looks straight foward to me.

> I choosed to base these changes on top of a more recent tree than
> armsoc/next/soc currently is based on (v3.13-rc1 vs v3.13-rc4) because
> to successfully build for ARM v7-M commit 5091333 (ARM: 7895/1: signal:
> fix armv7-m build issue in sigreturn_codes.S) which is included in
> v3.13-rc3 (but not earlier).

Yeah, we prefer using older -rcs where possible, but when you have a
good reason and describe it thoroughly (like you did), that's perfectly
fine.

Thanks for the detailed description.

Pulled into next/soc,

Kevin

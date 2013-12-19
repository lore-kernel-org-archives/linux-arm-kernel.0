From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 19 Dec 2013 07:20:42 -0800
Subject: [GIT PULL] get rid of <mach/timex.h>
In-Reply-To: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
 ("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Fri, 13 Dec 2013
 23:16:51 +0100")
References: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
Message-ID: <87bo0clved.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> Hello,
>
> the following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh
>
> for you to fetch changes up to c24eb46490c8232c08c82cd591ba332284d257b2:
>
>   ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too (2013-12-07 23:31:28 +0100)
>
> I'd like to get these changes into 3.14-rc1, so it would be great if you
> could take it into armsoc for some exposure into next.
>
> The kbuild test robot is happy with these changes, and I did several
> build tests, too, so I don't expect any breakage.
>
> Merging this series will result in a few merge conflicts. I pushed a
> branch dropmachtimexh-merged into my repository where you can see how I
> resolved them merging in current next/master into my tag.

I pulled this into our arm-soc/to-build for build and boot testing and
there was quite a few defconfigs that did not build (ignore the at91
failures, those are my fault):

   http://lists.linaro.org/pipermail/kernel-build-reports/2013-December/001573.html

Looks like there are still several users of LATCH, which references CLOCK_TICK_RATE
and is causing failures on lots of defconfigs.

I tried a few of those same defconfig builds on your merged branch and
it has the same build failures.

Kevin

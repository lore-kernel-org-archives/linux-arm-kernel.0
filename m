From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jun 2016 15:49:44 -0400 (EDT)
Subject: [RFC PATCH 0/4] ARM: remove big.LITTLE switcher support
In-Reply-To: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
References: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <alpine.LFD.2.20.1606271540000.2550@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jun 2016, Bartlomiej Zolnierkiewicz wrote:

> Hi,
> 
> It seems that in mainline kernel big.LITTLE switcher support
> may be usable only on ARM Versatile Express TC2 platform
> (but even this platform doesn't enable it in its defconfig).

It is also used on some Samsung targets.

> The following patchset removes big.LITTLE switcher support
> (from both ARM core and arm_big_little CPUfreq driver) in
> favor of using HMP.
> 
> Since HMP support at scheduler level is not yet merged this
> patchset is probably premature and thus is marked as RFC.

It is premature indeed.

And before this is removed, comparison with power/performance benchmark 
numbers will have to be provided as well to justify this removal.  At 
the moment there is nothing else in mainline that can achieve what this 
code does.

We all agree that the scheduler based solution is the best way to do it. 
But this has been a couple years already and this is still work in 
progress.


Nicolas

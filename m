From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Apr 2013 20:34:32 -0700
Subject: Exynos regressions w.r.t. config and debuggability due to
 multiplatform
Message-ID: <CAOesGMgRsa-AvbEZCc1=_ovaZMaG0S-CDok2MDp_zu5yderAYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

I think we should hold off on multiplatform for exynos until it works
better, i.e. 3.11.

First, the defconfig we have in our out-of-tree build system now
builds a broken kernel since it doesn't set ARCH_EXYNOS_SINGLE. As a
result, exynos gets turned off. It's quite awkward to switch between
pre- and post-multiplatform configs, which makes bisecting and other
error finding hard. I'm sure this will hit other downstream users too.

What's even more frustrating is that I can't turn on DEBUG_LL, since
serial drivers depend on PLAT_SAMSUNG, and that is no longer set.

Seems like we'll have a really broken 3.10 if we merge what we have
now. More bake time is definitely needed. :(


-Olof

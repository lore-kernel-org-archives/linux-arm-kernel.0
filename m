From: dianders@chromium.org (Doug Anderson)
Date: Wed, 8 May 2013 11:48:39 -0700
Subject: [PATCH] ARM: exynos: Select PINCTRL_EXYNOS for exynos5
In-Reply-To: <CAOesGMia9kLGh6B6QJZAKS1UpBg86v32S2um+0fjx5HYjje3cw@mail.gmail.com>
References: <1368034349-15091-1-git-send-email-dianders@chromium.org>
 <CAOesGMia9kLGh6B6QJZAKS1UpBg86v32S2um+0fjx5HYjje3cw@mail.gmail.com>
Message-ID: <CAD=FV=X2n+zHZ3frorwW7L1yybnWWK1=-rWMQJQFus3eNiFFeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Wed, May 8, 2013 at 11:19 AM, Olof Johansson <olof@lixom.net> wrote:
> Seems like this should be selected by the SoC (ARCH_EXYNOS5) instead
> of the board. Actually, I'm not sure we need the board Kconfig entry
> long-term; all boards will be dt-only.

Good point.  Hopefully someone at Samsung can work on removing the
board itself?  If you'd like me to take this on then let me know and I
can put it on my list.

I'm happy to resubmit my patch under ARCH_EXYNOS5.  I'll move the
exynos4 one at the same time.

I'm going to make the assumption that PINCTRL_EXYNOS and
PINCTRL_EXYNOS5440 can happily coexist.  Certainly I've got both
defined in my tree right now and nothing blows up.  I haven't tested
on 5440 but things ought to be handled by "compatible" checks, right?

I'll also assume that eventually someone will move PINCTRL_EXYNOS5440
into PINCTRL_EXYNOS.  If PINCTRL_EXYNOS5440 won't eventually move
under PINCTRL_EXYNOS then it makes less sense to define PINCTRL_EXYNOS
for all exynos parts.

-Doug

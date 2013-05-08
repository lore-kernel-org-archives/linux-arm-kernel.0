From: olof@lixom.net (Olof Johansson)
Date: Wed, 8 May 2013 12:33:34 -0700
Subject: [PATCH] ARM: exynos: Select PINCTRL_EXYNOS for exynos5
In-Reply-To: <CAD=FV=X2n+zHZ3frorwW7L1yybnWWK1=-rWMQJQFus3eNiFFeQ@mail.gmail.com>
References: <1368034349-15091-1-git-send-email-dianders@chromium.org>
 <CAOesGMia9kLGh6B6QJZAKS1UpBg86v32S2um+0fjx5HYjje3cw@mail.gmail.com>
 <CAD=FV=X2n+zHZ3frorwW7L1yybnWWK1=-rWMQJQFus3eNiFFeQ@mail.gmail.com>
Message-ID: <CAOesGMi=K4iJKjSk3RoynhiCMPPT98v5jADnqZ__TwX_YLw65Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Wed, May 8, 2013 at 11:48 AM, Doug Anderson <dianders@chromium.org> wrote:
> Olof,
>
> On Wed, May 8, 2013 at 11:19 AM, Olof Johansson <olof@lixom.net> wrote:
>> Seems like this should be selected by the SoC (ARCH_EXYNOS5) instead
>> of the board. Actually, I'm not sure we need the board Kconfig entry
>> long-term; all boards will be dt-only.
>
> Good point.  Hopefully someone at Samsung can work on removing the
> board itself?  If you'd like me to take this on then let me know and I
> can put it on my list.

Nothing stops you from doing that on your own. I tend to push back
onto the maintainers to get them engaged in their own housekeeping,
but anyone is free to :)

> I'm happy to resubmit my patch under ARCH_EXYNOS5.  I'll move the
> exynos4 one at the same time.

Great.

> I'm going to make the assumption that PINCTRL_EXYNOS and
> PINCTRL_EXYNOS5440 can happily coexist.  Certainly I've got both
> defined in my tree right now and nothing blows up.  I haven't tested
> on 5440 but things ought to be handled by "compatible" checks, right?

Yes, if they can't coexist then that's a bug.

> I'll also assume that eventually someone will move PINCTRL_EXYNOS5440
> into PINCTRL_EXYNOS.  If PINCTRL_EXYNOS5440 won't eventually move
> under PINCTRL_EXYNOS then it makes less sense to define PINCTRL_EXYNOS
> for all exynos parts.

Yeah, it should -- this is just in transition since 5440 was first out
of the gate with pinctrl.



-Olof

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 May 2013 08:29:40 +0900
Subject: [PATCH] ARM: exynos: Select PINCTRL_EXYNOS for exynos5
In-Reply-To: <CAD=FV=X1XL++O43GBcJK5Js=ci8pfoj=uSADMcqq_jGJEvhXdQ@mail.gmail.com>
References: <1368034349-15091-1-git-send-email-dianders@chromium.org>
 <CAD=FV=X2n+zHZ3frorwW7L1yybnWWK1=-rWMQJQFus3eNiFFeQ@mail.gmail.com>
 <CAOesGMi=K4iJKjSk3RoynhiCMPPT98v5jADnqZ__TwX_YLw65Q@mail.gmail.com>
 <1614776.P66h1VoFPp@amdc1227>
 <CAD=FV=X1XL++O43GBcJK5Js=ci8pfoj=uSADMcqq_jGJEvhXdQ@mail.gmail.com>
Message-ID: <044901ce4d0d$142a8e90$3c7fabb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote:
> 
> Tomasz / Olof,
> 
Hi Doug, Tomasz and Olof

> On Thu, May 9, 2013 at 2:45 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> >> Nothing stops you from doing that on your own. I tend to push back
> >> onto the maintainers to get them engaged in their own housekeeping,
> >> but anyone is free to :)
> 
> I will probably leave this to the maintainers at this point...  ;)
> 


> >> Yeah, it should -- this is just in transition since 5440 was first out
> >> of the gate with pinctrl.
> >
> > AFAIK, Exynos5440 contains a completely different pin controller block,
> which
> > is not compatible with pinctrl-samsung driver, so I don't see any point
> of
> > moving it under PINCTRL_EXYNOS, which is currently used for Exynos 4210,
> 4x12
> > and 5250, but will be also extended with driver data for S5PV210 as
well.
> >
> > I'd say that CPU_EXYNOS4210, SOC_EXYNOS4212, SOC_EXYNOS4412 and
> SOC_EXYNOS5250
> > should select PINCTRL_EXYNOS and SOC_EXYNOS5440 should be left as is,
> > selecting PINCTRL_EXYNOS5440.
> 
> OK, sounds reasonable.  I didn't dig into all of the details of the
> 5440 pin control driver and don't have a user manual in front of me.
> I will do as you say.
> 
Tomasz is right. The current exynos pinctrl stuff is quite different with
exynos5440 pinctrl, it means there is no reason to move exynos5440 pinctrl
under exynos pinctrl. Of course, both can be built together without problem.

> New patch coming shortly.
> 
Thanks, the PINCTRL_EXYNOS can be moved into under SoC condition not board.

- Kukjin

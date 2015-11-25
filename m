From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 10:03:02 +0100
Subject: [PATCH 1/3] clocksource: defbool CLKSRC_QCOM=y on ARCH_QCOM and
 make it visible
In-Reply-To: <565517D8.5000705@codeaurora.org>
References: <1448413710-8101-1-git-send-email-sboyd@codeaurora.org>
 <1448413710-8101-2-git-send-email-sboyd@codeaurora.org>
 <565517D8.5000705@codeaurora.org>
Message-ID: <18283780.80p4aZiYqH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 November 2015 18:07:20 Stephen Boyd wrote:
> On 11/24/15 17:08, Stephen Boyd wrote:
> > We want to remove the ARCH_MSM* configs in mach-qcom/Kconfig
> > because they are mostly proxy configs for selecting the right
> > clocksource driver. Therefore, make CLKSRC_QCOM default to the
> > value of ARCH_QCOM, but also make it visible if ARCH_QCOM=y so
> > that we can turn it off when we don't want it.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/clocksource/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index b423785d6afc..7a5ffaa3e490 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -279,9 +279,10 @@ config EM_TIMER_STI
> >         such as EMEV2 from former NEC Electronics.
> >  
> >  config CLKSRC_QCOM
> > -     bool "Qualcomm MSM timer" if COMPILE_TEST
> > +     bool "Qualcomm MSM timer" if ARCH_QCOM || COMPILE_TEST
> >       depends on ARM
> >       select CLKSRC_OF
> > +     defbool ARCH_QCOM
> 
> Urgh. This should be def_bool
> 
> 

With this fixed, the series looks good to me. If Daniel can Ack this,
I'd suggest we take the series through arm-soc.

	Arnd

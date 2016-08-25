From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Aug 2016 09:22:45 +0200
Subject: [PATCH 03/10] reset: lpc18xx: add driver Kconfig option
In-Reply-To: <CAGhQ9VzvU+1qzmmy9NeZmJxX7AS1ez6b4qJuq99J_drSpjJOUw@mail.gmail.com>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <1472045342-7434-3-git-send-email-p.zabel@pengutronix.de>
 <CAGhQ9VzvU+1qzmmy9NeZmJxX7AS1ez6b4qJuq99J_drSpjJOUw@mail.gmail.com>
Message-ID: <1472109765.3032.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 24.08.2016, 22:32 +0200 schrieb Joachim Eastwood:
> Hi Philipp,
> 
> On 24 August 2016 at 15:28, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Visible only if COMPILE_TEST is enabled, this allows to include the
> > driver in build tests.
> >
> > Cc: Joachim Eastwood <manabian@gmail.com>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/reset/Kconfig  | 7 +++++++
> >  drivers/reset/Makefile | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 1194cbe..8e33de2 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -27,6 +27,13 @@ config RESET_BERLIN
> >         help
> >           This enables the reset controller driver for Marvell Berlin SoCs.
> >
> > +config RESET_LPC18XX
> > +       bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
> > +       default ARCH_LPC18XX
> > +       help
> > +         This enables the LPC18xx/43 reset driver that supports the reset
> > +         controllers on AR71xx SoCs.
> 
> Don't know where you got the "AR71xx SoCs" from. This reset controller
> is found on NXP LPC18xx/43xx SoCs.
> 
> Other than that it looks fine to me.
> 
> Acked-by: Joachim Eastwood <manabian@gmail.com>

Thanks, copy and paste error. I'll fix it.

regards
Philipp

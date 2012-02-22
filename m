From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 22 Feb 2012 17:26:31 +0100
Subject: [PATCH v2 02/19] ARM: at91/at91x40: remove use of
 at91_sys_read/write
In-Reply-To: <201202221436.29474.arnd@arndb.de>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <fac36a5ab9fe5a8bd977d2305eeccad48389cbb5.1329903206.git.nicolas.ferre@atmel.com>
 <201202221436.29474.arnd@arndb.de>
Message-ID: <20120222162631.GE9407@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:36 Wed 22 Feb     , Arnd Bergmann wrote:
> Hi Nicolas and Jean-Christophe,
> 
> On Wednesday 22 February 2012, Nicolas Ferre wrote:
> > --- a/arch/arm/mach-at91/at91x40.c
> > +++ b/arch/arm/mach-at91/at91x40.c
> > @@ -44,7 +44,7 @@ static void at91x40_idle(void)
> >          * Disable the processor clock.  The processor will be automatically
> >          * re-enabled by an interrupt or by a reset.
> >          */
> > -       at91_sys_write(AT91_PS_CR, AT91_PS_CR_CPU);
> > +       __raw_writel(AT91_PS_CR_CPU, AT91_PS_CR);
> >         cpu_do_idle();
> >  }
> 
> How about making this writel_relaxed in the process?
> I would like to see the use of __raw_*() get reduced in code that gets
> touched. In most cases writel_relaxed/readl_relaxed is the correct
> accessor function instead.
It will for next release I plan to switch all of the at one

today I don't want to change it as the same time

Best Regards,
J.

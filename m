From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 21 Mar 2012 15:50:36 +0000
Subject: [PATCH] ARM: davinci: implement DEBUG_LL port choice
In-Reply-To: <20120320095413.GD15647@pengutronix.de>
References: <1331842703-4248-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120320095413.GD15647@pengutronix.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B631800A8C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Mar 20, 2012 at 15:24:13, Uwe Kleine-K?nig wrote:

> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index e0d236d..57019be 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -108,6 +108,22 @@ choice
> >  		bool "Kernel low-level debugging on 9263, 9g45 and cap9"
> >  		depends on HAVE_AT91_DBGU1
> >  
> > +	config DEBUG_DAVINCI_UART0
> > +		bool "Kernel low-level debugging on Davinci using uart0
> > +		depends on ARCH_DAVINCI_DM644x
> > +
> > +	config DEBUG_DA8XX_UART1
> > +		bool "Kernel low-level debugging on DA8xx using uart1"
> > +		depends on ARCH_DAVINCI_DA8XX
> > +
> > +	config DEBUG_DA8XX_UART2
> > +		bool "Kernel low-level debugging on DA8xx using uart2"
> > +		depends on ARCH_DAVINCI_DA8XX
> > +
> > +	config DEBUG_TNETV107X_UART1
> > +		bool "Kernel low-level debugging on TNETV107x using uart1
> > +		depends on ARCH_DAVINCI_TNETV107X
> > +
> on the first and the last description line there are the closing "
> missing. Should I resend?

Yes, please do so. I have not yet reviewed/tested this.

Thanks,
Sekhar

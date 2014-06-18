From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 18 Jun 2014 11:19:30 +0200
Subject: [PATCH] misc: atmel_pwm: only build for supported platforms
In-Reply-To: <20140528184217.GB30031@kroah.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-17-git-send-email-arnd@arndb.de>
 <536CA80A.60201@atmel.com> <1401279867.22486.6.camel@x220>
 <20140528155916.GA9793@piout.net> <1401293383.22486.18.camel@x220>
 <20140528175439.GA18470@piout.net> <1401299948.22486.51.camel@x220>
 <20140528184217.GB30031@kroah.com>
Message-ID: <1403083170.1984.70.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Wed, 2014-05-28 at 11:42 -0700, Greg Kroah-Hartman wrote:
> On Wed, May 28, 2014 at 07:59:08PM +0200, Paul Bolle wrote:
> > On Wed, 2014-05-28 at 19:55 +0200, Alexandre Belloni wrote:
> > > On 28/05/2014 at 18:09:43 +0200, Paul Bolle wrote :
> > > > On Wed, 2014-05-28 at 17:59 +0200, Alexandre Belloni wrote:
> > > > > On 28/05/2014 at 14:24:27 +0200, Paul Bolle wrote :
> > > > > > > >  config ATMEL_PWM
> > > > > > > >  	tristate "Atmel AT32/AT91 PWM support"
> > > > > > > > -	depends on HAVE_CLK && (AVR32 || ARCH_AT91 || COMPILE_TEST)
> > > > > > > > +	depends on HAVE_CLK
> > > > > > > > +	depends on AVR32 || AT91SAM9263 || AT91SAM9RL || AT91SAM9G45
> > > > > > 
> > > > > > Symbols AT91SAM9263, AT91SAM9RL, and AT91SAM9G45 do not seem to exist in
> > > > > > next-20140528. Should these perhaps be SOC_AT91SAM9263, SOC_AT91SAM9RL,
> > > > > > and SOC_AT91SAM9G45 and/or ARCH_AT91SAM9263, ARCH_AT91SAM9RL, and
> > > > > > ARCH_AT91SAM9G45?
> > > > > 
> > > > > I wouldn't bother too much fixing that, this will definitely be remove
> > > > > in 3.17. 
> > > > 
> > > > Are you talking about: 1) the problem this patch tried to fix; or 2) the
> > > > problem it created?
> > > > 
> > > 
> > > I'm removing the whole atmel_pwm driver so the CONFIG_ATMEL_PWM symbol
> > > will be gone.
> > 
> > So the patch we're discussing here will never be included in a release?
> 
> So, should I just remove it right now?  I like deleting files :)

This has landed unchanged in v3.16-rc1. Should I submit the trivial
patch to remove these pointless references to the unknown symbols
AT91SAM9263, AT91SAM9RL, and AT91SAM9G45?

Thanks,


Paul Bolle

From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 28 May 2014 18:09:43 +0200
Subject: [PATCH] misc: atmel_pwm: only build for supported platforms
In-Reply-To: <20140528155916.GA9793@piout.net>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-17-git-send-email-arnd@arndb.de>
 <536CA80A.60201@atmel.com> <1401279867.22486.6.camel@x220>
 <20140528155916.GA9793@piout.net>
Message-ID: <1401293383.22486.18.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-05-28 at 17:59 +0200, Alexandre Belloni wrote:
> On 28/05/2014 at 14:24:27 +0200, Paul Bolle wrote :
> > > >  config ATMEL_PWM
> > > >  	tristate "Atmel AT32/AT91 PWM support"
> > > > -	depends on HAVE_CLK && (AVR32 || ARCH_AT91 || COMPILE_TEST)
> > > > +	depends on HAVE_CLK
> > > > +	depends on AVR32 || AT91SAM9263 || AT91SAM9RL || AT91SAM9G45
> > 
> > Symbols AT91SAM9263, AT91SAM9RL, and AT91SAM9G45 do not seem to exist in
> > next-20140528. Should these perhaps be SOC_AT91SAM9263, SOC_AT91SAM9RL,
> > and SOC_AT91SAM9G45 and/or ARCH_AT91SAM9263, ARCH_AT91SAM9RL, and
> > ARCH_AT91SAM9G45?
> 
> I wouldn't bother too much fixing that, this will definitely be remove
> in 3.17. 

Are you talking about: 1) the problem this patch tried to fix; or 2) the
problem it created?

> I was too late for 3.16 because my series was waiting on
> another patch set.

We're already too late to fix stuff for v3.16-rc1 (which will probably
only be released about three to four weeks from now)? Is that correct?


Paul Bolle

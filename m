From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 28 May 2014 17:59:16 +0200
Subject: [PATCH] misc: atmel_pwm: only build for supported platforms
In-Reply-To: <1401279867.22486.6.camel@x220>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-17-git-send-email-arnd@arndb.de>
 <536CA80A.60201@atmel.com> <1401279867.22486.6.camel@x220>
Message-ID: <20140528155916.GA9793@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28/05/2014 at 14:24:27 +0200, Paul Bolle wrote :
> > >  config ATMEL_PWM
> > >  	tristate "Atmel AT32/AT91 PWM support"
> > > -	depends on HAVE_CLK && (AVR32 || ARCH_AT91 || COMPILE_TEST)
> > > +	depends on HAVE_CLK
> > > +	depends on AVR32 || AT91SAM9263 || AT91SAM9RL || AT91SAM9G45
> 
> Symbols AT91SAM9263, AT91SAM9RL, and AT91SAM9G45 do not seem to exist in
> next-20140528. Should these perhaps be SOC_AT91SAM9263, SOC_AT91SAM9RL,
> and SOC_AT91SAM9G45 and/or ARCH_AT91SAM9263, ARCH_AT91SAM9RL, and
> ARCH_AT91SAM9G45?
> 

I wouldn't bother too much fixing that, this will definitely be remove
in 3.17. I was too late for 3.16 because my series was waiting on
another patch set.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

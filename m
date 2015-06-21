From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Jun 2015 22:07:57 +0200
Subject: Linkstation Mini and __machine_arch_type problem, not booting
 since 3.8
In-Reply-To: <1434908164.5657.15.camel@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <55827D64.1090307@free-electrons.com>
 <1434678624.4767.22.camel@dolka.fr>
 <5583E1D9.2010002@free-electrons.com>
 <20150619114152.GA2936@io.lakedaemon.net>
 <1434760119.5177.6.camel@dolka.fr> <20150620143609.GE1116@lunn.ch>
 <1434908164.5657.15.camel@dolka.fr>
Message-ID: <20150621200757.GA12665@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 21, 2015 at 07:36:04PM +0200, Benjamin Cama wrote:
> Le samedi 20 juin 2015 ? 16:36 +0200, Andrew Lunn a ?crit :
> > > 
> > > > SERIAL_OF_PLATFORM?
> > > 
> > > Oh, and that was it!
> > 
> > This used to catch us all out a lot. What configuration are you using?
> > orion5x_defconfig? Very likely a patch adding it to that would be
> > accepted.
> 
> None. Sorry, I am used to the x86 world where I almost never used
> default configs (and it's been a long time, too). I admit I never fully
> understood the logic behind the defconfigs, apart from it meaning some
> kind of ???less important??? dependency on some specific options. Shouldn't
> the main UART be a ???hard??? dependency on every board?!

You say you are from the x86 world. When did you last use a serial
console on an x86? Anyway, the thinking at the time was that for most
NAS boxes, there is no DB-9 on the back. You have to open up the case,
and connect to a header, or even solder wires to the board, in order
to use a TTL-Serial converter. Very few people actually do that, so
why make the kernel a bit bigger?

But we have moved on since then, mostly because we ourselves have
forgotten this option too many times. We have SERIAL_OF_PLATFORM
enabled in the _defconfig.

	  Andrew

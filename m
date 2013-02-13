From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Feb 2013 11:04:01 +0000
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <511B59E2.5060402@stericsson.com>
References: <511A0F11.1050608@stericsson.com>
 <201302121741.31494.arnd@arndb.de> <511B59E2.5060402@stericsson.com>
Message-ID: <201302131104.01793.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013, Jean-Nicolas GRAUX wrote:
> Le 02/12/2013 06:41 PM, Arnd Bergmann a ?crit :
> > On Tuesday 12 February 2013, Jean-Nicolas GRAUX wrote:
> > If a more dynamic user interface is needed, I think it would be good
> > to have a generic mechanism in the pinctrl subsystem to reroute pins
> > like these, which can work for all pins in the system (or at least
> > those that have not been claimed by another device). I don't know if
> > that interface already exists, but Linus would be the right person
> > to answer that.
>
> I think i have one colleague that recently made a patch for that purpose.
> But i believe this is still in progress. It consists in improving the 
> pinctrl
> debugfs interface to be able to manually change the pin muxing and
> the gpio configuration for debug/testing purpose.

Sounds good to me. Peter, Tony, do you think that would be a good enough
interface for other platforms as well?

> > If there is a generic way to configure pinmux from user space, you
> > can essentially move this driver into an application running outside
> > of the kernel.
> >
> The matter is that this hwobs driver do more than just changing
> the muxing of one pin group in the digital baseband.
> It also control some specific registers to configure the hwobs IP.
> More in details, for each of the 18 external IOs, it is possible to
> select one observer mode among several. We also provide some
> facility for the user to easily detect the pin to monitor on the
> output connector.

Hmm, I wonder if that is something that makes sense to have
in a generic pinctrl debugfs interface. Maybe it can instead
be part of the new pinctrl driver for this hw block then, which
should be able to create additional sysfs files in the pinctrl
debugfs directories. Linus, does that make sense to you?

	Arnd

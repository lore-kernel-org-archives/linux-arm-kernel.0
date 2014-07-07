From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 00:26:21 -0700
Subject: [RFC PATCH] tty: serial: Add 8250-core based omap driver
In-Reply-To: <CAOCHtYhJODfoB10VXKtGC=_UaB4uVSZOtDwYG-XxL1wvcxi+fA@mail.gmail.com>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de>
 <20140702160932.GF5541@saruman.home>
 <20140702190944.GA567@drone.musicnaut.iki.fi>
 <CAOCHtYgxMeA+Arfe40XeFDEKuCJ8qo1RqNR0hYBGr_Wp6sRfdA@mail.gmail.com>
 <20140703073411.GX28884@atomide.com>
 <53B6DB74.2050401@linutronix.de>
 <CAOCHtYhJODfoB10VXKtGC=_UaB4uVSZOtDwYG-XxL1wvcxi+fA@mail.gmail.com>
Message-ID: <20140707072621.GE28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [140704 09:59]:
> On Fri, Jul 4, 2014 at 11:51 AM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > On 07/03/2014 09:34 AM, Tony Lindgren wrote:
> >> Heh. Just to summarize the reason ttyO needs to be a separate name
> >> and device entry from ttyS is because we also have external 8250
> >> devices on GPMC and hotplug busses.
> >
> > So the GPMC devices will first get a higher minor/device number. The
> > internal serial ports should show up first. I don't see the problem
> > (yet).
> >
> > If you need a separate major number (and name) like we do have it now
> > (between ttySx and ttyOx) then one of requirements would be to tell
> > Kconfig that one driver can be active at a time.
> >
> > For me the ttyS vs ttyO thing is purely cosmetic. I personally don't
> > like that it is different on different platforms like ttymxc, ttySC,
> > ttyTHS, ?

The dev entry had to be different with serial-omap as it was not
using 8250 code. With the code moving back to using 8250 code
there are no dev conflicts so ttyS is just fine as the 8250 code
handles allocating the devices.
 
> Maybe it's time to migrate them all to one name? (ttyS)  Does the end
> user really care if they have a soc with an omap/imx serial port
> driver? Or do they just want to access /dev/ttySx and connect to their
> device?

Yes the 8250 code should always use ttyS. Then maybe we could
have also ttyO dev entries created by the driver for compability.

Earlier serial-omap could not provide the ttyS compability easily
because they were separate drivers.

Regards,

Tony

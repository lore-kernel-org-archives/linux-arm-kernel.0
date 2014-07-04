From: robertcnelson@gmail.com (Robert Nelson)
Date: Fri, 4 Jul 2014 11:57:40 -0500
Subject: [RFC PATCH] tty: serial: Add 8250-core based omap driver
In-Reply-To: <53B6DB74.2050401@linutronix.de>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de>
 <20140702160932.GF5541@saruman.home>
 <20140702190944.GA567@drone.musicnaut.iki.fi>
 <CAOCHtYgxMeA+Arfe40XeFDEKuCJ8qo1RqNR0hYBGr_Wp6sRfdA@mail.gmail.com>
 <20140703073411.GX28884@atomide.com>
 <53B6DB74.2050401@linutronix.de>
Message-ID: <CAOCHtYhJODfoB10VXKtGC=_UaB4uVSZOtDwYG-XxL1wvcxi+fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 11:51 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 07/03/2014 09:34 AM, Tony Lindgren wrote:
>> Heh. Just to summarize the reason ttyO needs to be a separate name
>> and device entry from ttyS is because we also have external 8250
>> devices on GPMC and hotplug busses.
>
> So the GPMC devices will first get a higher minor/device number. The
> internal serial ports should show up first. I don't see the problem
> (yet).
>
> If you need a separate major number (and name) like we do have it now
> (between ttySx and ttyOx) then one of requirements would be to tell
> Kconfig that one driver can be active at a time.
>
> For me the ttyS vs ttyO thing is purely cosmetic. I personally don't
> like that it is different on different platforms like ttymxc, ttySC,
> ttyTHS, ?

Maybe it's time to migrate them all to one name? (ttyS)  Does the end
user really care if they have a soc with an omap/imx serial port
driver? Or do they just want to access /dev/ttySx and connect to their
device?

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/

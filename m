From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 04 Dec 2013 13:04:00 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGkuTVgyNzogQ29uZmlndXJlIEdQSU9z?=
 =?UTF-8?B?IGFzICJpbnB1dCIgYnkgZGVmYXVsdA==?=
In-Reply-To: <20131204095703.236ccbe0@ipc1.ka-ro>
References: <1385795000-29764-1-git-send-email-shc_work@mail.ru>
 <20131203133045.GC28465@pengutronix.de>
 <20131204095703.236ccbe0@ipc1.ka-ro>
Message-ID: <1386147840.110296074@f57.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On Tue, Dec 03, 2013 at 04:46:27PM +0800, Shawn Guo wrote:
> > > On Sat, Nov 30, 2013 at 11:03:20AM +0400, Alexander Shiyan wrote:
> > > > This patch changes the default direction for pins used
> > > > as GPIO to "input". This prevents a short circuit on the
> > > > configuration stage when GPIO-pin is connected to the
> > > > other output pin.
> > > 
> > > Markus,
> > > 
> > > Does it make sense to you?
> > 
> > I am not sure if this really happens. However, it does make sense and I
> > can't see any disadvantages in changing the default GPIO mux direction to
> > input.
> > 
> What happens, if the bootloader already set up a pin as output and
> linux later does the pinconfig stuff?
> If the pin is reconfigured as input then, this may produce an unwanted
> glitch on the pin. IMO the pinconfig driver should not touch the pin
> direction, but leave it to the gpio driver to set that up. 

Such pin can be overridden by board DTS.

---

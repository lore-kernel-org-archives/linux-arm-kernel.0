From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 4 Dec 2013 09:57:03 +0100
Subject: [PATCH] ARM: dts: i.MX27: Configure GPIOs as "input" by default
In-Reply-To: <20131203133045.GC28465@pengutronix.de>
References: <1385795000-29764-1-git-send-email-shc_work@mail.ru>
 <20131203084624.GI10840@S2101-09.ap.freescale.net>
 <20131203133045.GC28465@pengutronix.de>
Message-ID: <20131204095703.236ccbe0@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Markus Pargmann wrote:
> Hi,
> 
> On Tue, Dec 03, 2013 at 04:46:27PM +0800, Shawn Guo wrote:
> > On Sat, Nov 30, 2013 at 11:03:20AM +0400, Alexander Shiyan wrote:
> > > This patch changes the default direction for pins used
> > > as GPIO to "input". This prevents a short circuit on the
> > > configuration stage when GPIO-pin is connected to the
> > > other output pin.
> > 
> > Markus,
> > 
> > Does it make sense to you?
> 
> I am not sure if this really happens. However, it does make sense and I
> can't see any disadvantages in changing the default GPIO mux direction to
> input.
> 
What happens, if the bootloader already set up a pin as output and
linux later does the pinconfig stuff?
If the pin is reconfigured as input then, this may produce an unwanted
glitch on the pin. IMO the pinconfig driver should not touch the pin
direction, but leave it to the gpio driver to set that up. 


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

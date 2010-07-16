From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 10:25:31 +0100
Subject: [PATCH 1/3] ARM: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <201007161119.55769.arnd@arndb.de>
References: <1278429668-4564-1-git-send-email-triad@df.lth.se>
	<20100715102237.GI26212@n2100.arm.linux.org.uk>
	<AANLkTinxE6hbgVWqvxen6yDNM1VLgK2DFnMyN_o_zbsw@mail.gmail.com>
	<201007161119.55769.arnd@arndb.de>
Message-ID: <20100716092531.GC16995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 11:19:55AM +0200, Arnd Bergmann wrote:
> On Thursday 15 July 2010, Linus Walleij wrote:
> > > Or maybe drivers/platform/arm/ (to avoid Linus' complaint about
> > > drivers under arch/ ?)
> > 
> > Creating that for a single driver seems weird, I could just as well
> > create drivers/lcd for all LCDs in that case. But there is another
> > LCD-like driver for a USB-connected LCD under drivers/misc
> > IIRC, maybe I can make a patch for that as well and let the misc
> > maintainer decide if he wants it.
> 
> Most drivers are in directories based on the software interface, but
> as you explained, the driver does not interface with anything so far.
> 
> Other display drivers are under drivers/video. If it makes sense
> to use the display as the console, you could put it in
> drivers/video/console/. Another option would be to make it
> a tty and move it to driver/char.

It's a 2 line by 8 character LCD.  I don't think it makes sense for it
to be a console or even a tty driver.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Nov 2010 00:01:52 +0000
Subject: [PATCH] pl011: added clock management feature
In-Reply-To: <20101109224012.GA21992@kroah.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
	<20101109224012.GA21992@kroah.com>
Message-ID: <20101110000152.GA8993@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 02:40:12PM -0800, Greg KH wrote:
> On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
> > From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
> > 
> > This patch allows to control the pl011 clock using set_termios
> > callback. Any positive baudrate passed enables clock, otherwise
> > disables. This saves a lot of power on submicron designs since
> > we can clock off and disable unused UARTs.
> 
> That's nice, but it seems like an overload of what people traditionally
> think of when it comes to baud rates.  Why not just power down ports
> that are not open instead?

We already do.  My question to Linus (in a previous message) is why this
isn't sufficient.

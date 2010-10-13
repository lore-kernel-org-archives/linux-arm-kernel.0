From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 13 Oct 2010 11:08:35 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <201010131944.54135.arnd@arndb.de>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010131721.39623.arnd@arndb.de>
	<1286986623.28336.3.camel@c-dwalke-linux.qualcomm.com>
	<201010131944.54135.arnd@arndb.de>
Message-ID: <1286993315.28336.10.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-13 at 19:44 +0200, Arnd Bergmann wrote:
> On Wednesday 13 October 2010 18:17:03 Daniel Walker wrote:
> > > I think you would be much better off making it a "hvc" driver, where
> > > you just need to provide a read character and write character function
> > > and an optional interrupt handler but otherwise have the common hvc
> > > code take care of polling the hardware and talking to the tty layer.
> > 
> > I don't know what the "hvc" driver is "Hypervisor Virtual Console"
> > maybe?
> 
> Yes, it originally was used only on hypervisors that had simple
> read/write type consoles, but has now turned into a generic facility
> that is used by a number of consoles that don't look like classic
> serial ports.
> 
> > Can you give any sort of example driver which does what you
> > suggesting?
> 
> Look at drivers/char/hvc_tile.c for the simplest case or
> drivers/char/hvc_vio.c for one that uses interrupts.

I found it independently actually .. It looks like there's at least two
problems. This jtag driver has a status register which flags when RX is
available, and TX is possible. I'm not sure this status register fits
into the model. The other thing is that we have a ttyJ registered for
this driver, and it would be nice to use that over something like ttyHVC
(I'm not sure if that name is correct, just a guess).

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Oct 2010 19:44:53 +0200
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1286986623.28336.3.camel@c-dwalke-linux.qualcomm.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010131721.39623.arnd@arndb.de>
	<1286986623.28336.3.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <201010131944.54135.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 October 2010 18:17:03 Daniel Walker wrote:
> > I think you would be much better off making it a "hvc" driver, where
> > you just need to provide a read character and write character function
> > and an optional interrupt handler but otherwise have the common hvc
> > code take care of polling the hardware and talking to the tty layer.
> 
> I don't know what the "hvc" driver is "Hypervisor Virtual Console"
> maybe?

Yes, it originally was used only on hypervisors that had simple
read/write type consoles, but has now turned into a generic facility
that is used by a number of consoles that don't look like classic
serial ports.

> Can you give any sort of example driver which does what you
> suggesting?

Look at drivers/char/hvc_tile.c for the simplest case or
drivers/char/hvc_vio.c for one that uses interrupts.

	Arnd

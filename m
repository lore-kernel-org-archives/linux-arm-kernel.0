From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 May 2010 21:48:36 +0100
Subject: [PATCH v4 4/5(7)] input: serio: add support for Amstrad Delta
	serial keyboard port
In-Reply-To: <20100504204041.GL29604@atomide.com>
References: <201004280252.58420.jkrzyszt@tis.icnet.pl>
	<201004280310.52678.jkrzyszt@tis.icnet.pl>
	<20100504204041.GL29604@atomide.com>
Message-ID: <20100504204836.GJ30601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 01:40:41PM -0700, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100427 18:09]:
> > The patch introduces a serio driver that supports a keyboard serial port found
> > on the Amstrad Delta videophone board.
> > 
> > After initializing the hardware, the driver reads its input data from a buffer
> > filled in by the board FIQ (Fast Interrupt Request) handler.
> > 
> > Standard AT keyboard driver (atkbd) will be used on top of the serio layer for 
> > handling the E3 keyboard (called mailboard) connected to the port. Since the 
> > device generated scancodes differ from what the atkbd expects, a custom key 
> > code to scan code table must be loaded from userspace for the keyboard to be 
> > useable.

What's the rationale for this approach?  There's no requirement for the
atkbd driver to be used for all keyboards.  It seems very obscure (and
backward) way to do things.

Why not implement the serio driver for the IO level, and a separate
keyboard driver which can handle the protocol and interpret the
scancodes?

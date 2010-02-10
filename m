From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Feb 2010 08:30:12 +0000
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <20100210011637.GA8683@shareable.org>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
	<20100208135124.GA26608@n2100.arm.linux.org.uk>
	<20100209143055.GA6015@bnru01.bnr.st.com>
	<20100209221449.GA23083@n2100.arm.linux.org.uk>
	<20100210011637.GA8683@shareable.org>
Message-ID: <20100210083012.GA11701@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2010 at 01:16:37AM +0000, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > This means that when the kernel's buffers fill up, the kernel calls
> > down to the serial core layer to throttle the input.  This then
> > calls into the set_mctrl function to de-assert RTS.  However, because
> > the hardware ignores the requested software state, the RTS signal
> > is not de-asserted, and the remote end continues sending data.
> > 
> > So, enabling hardware auto-RTS is bad news - you will lose data if
> > the application stops reading data.
> 
> Surely the driver can just stop reading from the UART when the
> kernel's buffers are full and hardware-RTS is enabled.  Then the
> hardware will deassert RTS itself.

I'll let you work out how to implement that.

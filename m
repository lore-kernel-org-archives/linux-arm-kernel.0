From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 12 Feb 2011 14:52:34 -0500 (EST)
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <20110211144207.GJ23404@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1101121314470.25498@xanadu.home>
	<20110112184258.GH11039@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101121350350.25498@xanadu.home>
	<AANLkTikLwTdV2B5Dyp_adCxgWcE-+Wb6uiN5MBfnA1_K@mail.gmail.com>
	<alpine.LFD.2.00.1101270030220.8580@xanadu.home>
	<20110210154322.GE1742@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102101405010.14920@xanadu.home>
	<AANLkTi=KtFf5BU-iH-sUUL=Q30S90bk608JR4zFz2CKf@mail.gmail.com>
	<alpine.LFD.2.00.1102110838430.14920@xanadu.home>
	<AANLkTimW9zQ3EcEo8+gcxnS72Wa9VZELvrqdY+jP0B7W@mail.gmail.com>
	<20110211144207.GJ23404@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102121435470.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Feb 2011, Russell King - ARM Linux wrote:

> On Fri, Feb 11, 2011 at 02:25:28PM +0000, Dave Martin wrote:
> >  if we can also move the initramfs somewhere less obstructive in the
> > future, then so much the better.
> 
> This may do it, and it might even work.  Not particularly well tested
> yet.  It'd be loads easier if we didn't have to worry about XIP.

Is anyone actually still using XIP these days?  Now that NOR flash is 
not that much used anymore, if maintaining XIP support is more trouble 
than it is worth we could simply deprecate it.  The linker script has 
become quite more hairy than it used to be, and from a quick look I'm 
not even sure if all the stuff in there is properly located for XIP.

Otherwise, for the __init stuff move:

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas

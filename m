From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 13 Oct 2010 13:00:55 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <alpine.LFD.2.00.1010131551390.2764@xanadu.home>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010131721.39623.arnd@arndb.de>
	<1286986623.28336.3.camel@c-dwalke-linux.qualcomm.com>
	<201010131944.54135.arnd@arndb.de>
	<1286993315.28336.10.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010131551390.2764@xanadu.home>
Message-ID: <1287000055.28336.19.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-13 at 15:55 -0400, Nicolas Pitre wrote:
> > I found it independently actually .. It looks like there's at least two
> > problems. This jtag driver has a status register which flags when RX is
> > available, and TX is possible. I'm not sure this status register fits
> > into the model. The other thing is that we have a ttyJ registered for
> > this driver, and it would be nice to use that over something like ttyHVC
> > (I'm not sure if that name is correct, just a guess).
> 
> Really?  Is there a compelling reason to perpetuate this serial device 
> namespace fragmentation nonsense?  Your initial patch even had a config 
> option to hijack /dev/ttyS0 because of that.

I'm not sure how to interpret what your saying .. Are you saying we
should use /dev/hvcX or shouldn't ? the reason I want to use ttyJ is
because it was assigned specifically for jtags which, to me, makes
things a lot less confusing.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

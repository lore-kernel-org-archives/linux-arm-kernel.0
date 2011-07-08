From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 17:03:29 +0100
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <alpine.LFD.2.00.1107080941090.14596@xanadu.home>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
	<4E15ECB6.40100@codeaurora.org>
	<20110707223620.GG20403@n2100.arm.linux.org.uk>
	<4E165597.90002@codeaurora.org>
	<20110708090721.GC2414@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107080941090.14596@xanadu.home>
Message-ID: <20110708160329.GF4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 09:46:42AM -0400, Nicolas Pitre wrote:
> On Fri, 8 Jul 2011, Russell King - ARM Linux wrote:
> 
> > There's also platforms where the zImage is loaded at some predetermined
> > offset into RAM to give the decompressor room to directly place the
> > kernel in its final location too, which will be buggered by
> > AUTO_ZRELADDR.
> 
> How so?  Loading that zImage at the same predetermined offset will still 
> have the same desired effect.  As long as the offset is within 128MB of 
> the start of RAM.

You just said it...

Given that it's 128MB, Stephen shouldn't have a problem with loading the
zImage at 0xN0208000, but he said it doesn't work.  I think there's some
work to be done there to figure out if Stephen really has a problem, and
what that problem is.

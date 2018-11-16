From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Nov 2018 17:47:06 +0000
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <alpine.LNX.2.21.1811151427210.19@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
 <20181114141632.GT30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811151427210.19@nippy.intranet>
Message-ID: <20181116174705.GY30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 03:12:17PM +1100, Finn Thain wrote:
> The thread went way off-topic when Christoph took the opportunity to 
> suggest the removal of RPC and EBSA110. That doesn't interest me.

I suspect that is the right solution - I've been trying to get 4.19
to boot on my RPC and it's proving very difficult for several reasons,
not limited to the HDD seeming to be throwing the odd disk error, as
well as the kernel being rather large (a 4.19 kernel is 2.7M compressed
as opposed to 2.6.29 being 1.2M compressed for the equivalent
configuration.)

Given that memory on the RPC is not contiguous, that probably means
an uncompressed kernel overflows the size of the first memory bank,
so there's probably no hope for modern kernels to boot on the machine.

The EBSA110 is probably in a similar boat - I don't remember whether it
had 16MB or 32MB as the maximal amount of memory, but memory was getting
tight with some kernels even running a minimalist userspace.

So, it's probably time to say goodbyte to the kernel support for these
platforms.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

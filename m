From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 07 Dec 2009 10:24:06 -0500 (EST)
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <309002C0DA137042828828FC53D7A9347E212D14F6@IL-MB01.marvell.com>
References: <4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E212D14D4@IL-MB01.marvell.com>
	<4B1CF4A5.2080201@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D14F6@IL-MB01.marvell.com>
Message-ID: <alpine.LFD.2.00.0912071020040.31174@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Dec 2009, Ronen Shitrit wrote:

> From: Heiko Schocher [mailto:hs at denx.de] 
> > Hello Ronen,
> > 
> > Ronen Shitrit wrote:
> > > It's definitely this issue. 
> > > If I disable L2 everything works.
> > 
> > How did you exactly disabled the L2 Cache? And on which system
> > did you this test?
> 
> Disable CONFIG_CACHE_FEROCEON_L2 in the config.
> I'm using KW-DB kernel 2.6.31.4.

Beware that if you're using the original Marvell provided U-Boot, you 
need to disable L2 in the kernel _and_ in the U-Boot environment.  If 
L2 is disabled in the kernel but not in U-Boot then stranger things may 
happen.  Best thing to do is to keep L2 in U-Boot always disabled and 
let the kernel enable it as needed.


Nicolas

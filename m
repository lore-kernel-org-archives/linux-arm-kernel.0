From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 25 Feb 2010 16:25:21 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100225210500.GI3101@n2100.arm.linux.org.uk>
References: <20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
	<4B864B4C.9020805@marcansoft.com>
	<alpine.LFD.2.00.1002251332190.1946@xanadu.home>
	<4B86CDC8.4080107@marcansoft.com>
	<alpine.LFD.2.00.1002251428410.1946@xanadu.home>
	<4B86D5D8.2010905@marcansoft.com>
	<alpine.LFD.2.00.1002251507000.1946@xanadu.home>
	<20100225210500.GI3101@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1002251611100.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Russell King - ARM Linux wrote:

> On Thu, Feb 25, 2010 at 03:29:07PM -0500, Nicolas Pitre wrote:
> > On Thu, 25 Feb 2010, Hector Martin wrote:
> > > But this discussion is rather pointless because at this stage I highly
> > > doubt Russell is going to change his mind.
> > 
> > If you produce a patch for the above, and it is clean and portable, then 
> > I suspect he would just merge it.  Only at that point we could 
> > reconsider the ROMable decompressor issue.
> 
> Hector's arguments have been based around denying various well defined
> features of the ELF shared library support, and it would be wreckless
> of me to accept changes based upon denials.

I think we've pretty much settled this now.

It is however true that the decompressor code doesn't have the 
decompressed kernel size and that a 4x expansion is assumed which is not 
optimal.  This alone, without mixing it up with other issues, should be 
sufficient for considering an eventual patch from Hector if his fix is 
well done.  That's what I was referring to above, and I think the 
ROMable decompressor structure change can be postponed until real issues 
with it actually arise.


Nicolas

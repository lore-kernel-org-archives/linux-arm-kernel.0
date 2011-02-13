From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 13 Feb 2011 09:23:42 -0500 (EST)
Subject: The p2v branch
In-Reply-To: <20110213114050.GB4799@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
	<20110212184138.GD22402@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102121556330.14920@xanadu.home>
	<20110213114050.GB4799@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102130915120.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Feb 2011, Russell King - ARM Linux wrote:

> On Sat, Feb 12, 2011 at 04:01:14PM -0500, Nicolas Pitre wrote:
> > I've rebased my 2 patches on top of your latest p2v branch.  You may 
> > pull them from:
> > 
> > 	git://git.linaro.org/people/nico/linux p2v
> > 
> > Or if you prefer I can put them in the patch system.
> 
> I'd like to wait for Catalin to respond on the phys_addr_t patch - which
> allows 64-bit phys addresses.  Obviously that's going to have an impact
> on the p2v code and I'd rather someone else had the job of working out
> what to do about the T2 code.

OK.

Thinking ahead a bit, what changes would be needed? Obviously, there 
can't be a machine with all its RAM above the 4G limit or it wouldn't be 
able to run without the MMU on.  And the p2v/v2p conversion macros can 
only be used on the direct mapped memory i.e. the non highmem memory 
which is likely to be all located below that 4G limit.  In that case the 
fixup code shouldn't be affected, right?


Nicolas

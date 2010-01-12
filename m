From: dan@debian.org (Daniel Jacobowitz)
Date: Tue, 12 Jan 2010 09:25:23 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <1263292498.29654.26.camel@pc1117.cambridge.arm.com>
References: <20100111215816.GA1068@caradoc.them.org>
	<1263292498.29654.26.camel@pc1117.cambridge.arm.com>
Message-ID: <20100112142523.GA28804@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 10:34:58AM +0000, Catalin Marinas wrote:
> On Mon, 2010-01-11 at 21:58 +0000, Daniel Jacobowitz wrote:
> > The kernel currently reserves two architecturally undefined
> > instructions for breakpoints, one ARM and one Thumb.  I suggest
> > another for Thumb-2, provisionally 0xfff7 0xffcf, but I'm open
> > to any other suggestion.  Any comments?  If that sounds OK,
> > I can put together a patch.
> 
> I find the reasons good enough to add a 32-bit Thumb-2 breakpoint
> instruction.
> 
> Regarding the opcode, can we not use a permanently undefined one? There
> is A6.3.4 in the ARM ARM defining such encoding. Maybe something like
> 0xf7f0 a000 (or 0xa000 f7f0 if you write it as a 32-bit word).

Thanks, I meant to but messed up the byte ordering (and more).  I got
something currently undefined, and didn't notice :-(

I'll plan on 0xf7f0 0xa000.

-- 
Daniel Jacobowitz
CodeSourcery

From: dan@debian.org (Daniel Jacobowitz)
Date: Mon, 11 Jan 2010 19:22:01 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100112001728.GB4465@shareable.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
	<20100111231027.GA30714@shareable.org>
	<20100111231702.GA9485@caradoc.them.org>
	<20100112001728.GB4465@shareable.org>
Message-ID: <20100112002201.GA14280@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 12:17:28AM +0000, Jamie Lokier wrote:
> And therefore, would it be possible to modify the CPSR when
> single-stepping to change the IT state so that the instruction
> following the next one, i.e. the breakpoint, is unconditional?
> So you only need one breakpoint after all.

Yes, I thought about doing this.  However, the many combinations of
ways you'd have to restore the modified CPSR gave me a fright.  I
don't think it's a robust solution.  It's just different enough from
out-of-line stepping to be unable to share the code.

-- 
Daniel Jacobowitz
CodeSourcery

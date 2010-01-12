From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jan 2010 18:01:27 +0000
Subject: question about ARM11MP cpu architecture identification
In-Reply-To: <20100112172422.GD5633@n2100.arm.linux.org.uk>
References: <c70ff3ad1001120821u1f546480nd0229e560d84293@mail.gmail.com>
	<1263313572.29654.105.camel@pc1117.cambridge.arm.com>
	<20100112164220.GJ27771@n2100.arm.linux.org.uk>
	<1263315302.29654.110.camel@pc1117.cambridge.arm.com>
	<c70ff3ad1001120903i62b96731ld8c1820be00fb41b@mail.gmail.com>
	<20100112171733.GC5633@n2100.arm.linux.org.uk>
	<20100112172422.GD5633@n2100.arm.linux.org.uk>
Message-ID: <1263319287.29654.112.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-12 at 17:24 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 12, 2010 at 05:17:33PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 12, 2010 at 07:03:35PM +0200, saeed bishara wrote:
> > > On Tue, Jan 12, 2010 at 6:55 PM, Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > > On Tue, 2010-01-12 at 16:42 +0000, Russell King - ARM Linux wrote:
> > > >> On Tue, Jan 12, 2010 at 04:26:12PM +0000, Catalin Marinas wrote:
> > > >> > On Tue, 2010-01-12 at 16:21 +0000, saeed bishara wrote:
> > > >> > >     The ARM11MP (rev r2p0) cpu architecture is ARMv6, and according to
> > > >> > > the http://infocenter.arm.com, its Main ID register is 0x410FB024, and
> > > >> > > the MMFR[3:0] is 3. but it looks to me that the cpu_architecture()
> > > >> > > will identify it as ARMv7, and if the kernel was configured with
> > > >> > > CPU_V7 only, then the lookup_processor_type() function also will
> > > >> > > identify it as ARMv7. Am I missing something here?
> > > >> >
> > > >> > cpu_architecture() returns the architecture version of the supported MMU
> > > >> > which on ARM11MPCore is the same as on ARMv7.
> > > >> >
> > > >> > Even if it is possible to configure both v6 and v7 in the same kernel, I
> > > >> > don't think it is currently possible to successfully run such kernel.
> > > >>
> > > >> What makes you think that?  I've been building v6+v7 kernels for Realview
> > > >> (with a patch to provide the right build options for the ARMv7 arch/arm/mm
> > > >> files) and ISTR it works fine on my Realview board.
> > > >
> > > > I don't remember exactly but it didn't work for me some time ago. I
> > > > think it failed to build (though I could have worked around this with
> > > > something like -march=all).
> > > >
> > > I think you need the attached patch from Lennert (it was planned to be
> > > sent later by me)
> >
> > Using -Wa,-march= for assembler options is actually a better idea.
> > I'll update my patch with that (which actually reflects what I did
> > for Integrator/CP with ARM926 + v6).
> 
> Ok, here's the combined patch.  Ack?

Looks fine to me. Thanks.

-- 
Catalin

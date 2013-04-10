From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 10 Apr 2013 19:19:34 -0400 (EDT)
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <yw1xsj2y6n84.fsf@unicorn.mansr.com>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <yw1xmwt68whw.fsf@unicorn.mansr.com>
 <20130410114229.GH14496@n2100.arm.linux.org.uk>
 <yw1xip3u8uni.fsf@unicorn.mansr.com>
 <20130410185421.GI14496@n2100.arm.linux.org.uk>
 <yw1xehei8a19.fsf@unicorn.mansr.com>
 <20130410200344.GO14496@n2100.arm.linux.org.uk>
 <yw1x61zu866d.fsf@unicorn.mansr.com>
 <20130410210431.GQ14496@n2100.arm.linux.org.uk>
 <yw1x1uai84p9.fsf@unicorn.mansr.com>
 <20130410214509.GT14496@n2100.arm.linux.org.uk>
 <yw1xsj2y6n84.fsf@unicorn.mansr.com>
Message-ID: <alpine.LFD.2.03.1304101912020.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Apr 2013, M?ns Rullg?rd wrote:

> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > - A9 is ARMv7.
> > - Vector operations are deprecated in ARMv7.
> > - Whether vector operations are implemented is up to the implementer.
> > - If they aren't implemented, they will cause an undefined instruction
> >   exception.
> > - If the VFP subarchitecture says '3' that means no support code is
> >   required by the implementation.
> >
> > All together, that means that on ARMv7, of which Cortex-A9 is one such
> > implementation, vector operations *are* *deprecated* may or may not be
> > implement in hardware.  If they are not implemented in hardware *and*
> > the VFP subarchitecture reports '3', then you _should_ strictly get a
> > SIGILL for them and not have them executed because they are _deprecated_
> > *and* _unsupported_ instructions.
> 
> So you're saying the current kernel behaviour of emulating the vector
> operations on A9 is in error.  I suppose I could agree with that

Given Russell's explanation above that's my opinion too.

> (although the system response to an undefined instruction is not
> specified by the architecture),

It is defined by POSIX.


Nicolas

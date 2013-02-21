From: kim.phillips@freescale.com (Kim Phillips)
Date: Wed, 20 Feb 2013 21:49:43 -0600
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <alpine.LFD.2.03.1302201040460.6419@syhkavp.arg>
References: <20130129181046.GC25415@pd.tnic>
 <20130205210436.670c62e26d2121330e87af35@freescale.com>
 <1360141322.6066.4.camel@shinybook.infradead.org>
 <20130206191905.ac8eb6743e69425f30888704@freescale.com>
 <20130207181315.GM17833@n2100.arm.linux.org.uk>
 <1360344301.6066.263.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081503430.6300@xanadu.home>
 <1360363233.6066.283.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081745500.6300@xanadu.home>
 <20130208191208.2ef3d78bda71aa7b44d00d7b@freescale.com>
 <alpine.LFD.2.02.1302082102380.6300@xanadu.home>
 <20130219203115.114eab79e8d2099c6306d921@freescale.com>
 <alpine.LFD.2.03.1302192151280.6419@syhkavp.arg>
 <1361356696.13482.269.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200835380.6419@syhkavp.arg>
 <1361367842.13482.279.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200905300.6419@syhkavp.arg>
 <1361372008.13482.280.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302201040460.6419@syhkavp.arg>
Message-ID: <20130220214943.9b28a5b208da9f081387c55e@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Feb 2013 10:43:18 -0500
Nicolas Pitre <nico@fluxnic.net> wrote:

> On Wed, 20 Feb 2013, Woodhouse, David wrote:
> > On Wed, 2013-02-20 at 09:06 -0500, Nicolas Pitre wrote:
> > > ... in which case there is no harm shipping a .c file and trivially 
> > > enforcing -O2, the rest being equal.
> > 
> > For today's compilers, unless the wind changes.
> 
> We'll adapt if necessary.  Going with -O2 should remain pretty safe anyway.

Alas, not so for gcc 4.4 - I had forgotten I had tested
Ubuntu/Linaro 4.4.7-1ubuntu2 here:

https://patchwork.kernel.org/patch/2101491/

add -O2 to that test script and gcc 4.4 *always* emits calls to
__bswap[sd]i2, even with -march=armv6k+.

I'll try working on an assembly version given it probably
makes more sense, future-gcc-immunity-wise.

Otherwise we're back to the old 'if GCC_VERSION >= 40500' in
arch/arm/include/asm/swab.h...

Kim

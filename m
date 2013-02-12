From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 12 Feb 2013 16:45:34 -0500 (EST)
Subject: [PATCH 05/17] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <5119427E.3000502@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-6-git-send-email-ben.dooks@codethink.co.uk>
 <alpine.LFD.2.02.1302082237590.6300@xanadu.home>
 <5119427E.3000502@codethink.co.uk>
Message-ID: <alpine.LFD.2.03.1302121643440.1242@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Feb 2013, Ben Dooks wrote:

> On 09/02/13 03:40, Nicolas Pitre wrote:
> > On Fri, 8 Feb 2013, Ben Dooks wrote:
> > 
> > > The fixup_pv_table assumes that the instructions are in the same
> > > endian configuration as the data, but when the CPU is running in
> > > BE8 the instructions stay in little-endian format.
> > > 
> > > Make sure if CONFIG_CPU_ENDIAN_BE8 is set that we do all the
> > > alterations to the instructions taking in to account the LDR/STR
> > > will be swapping the data endian-ness.
> > > 
> > > Since the code is only modifying a byte, we avoid dual-swapping
> > > the data, and just change the bits we clear and ORR in.
> > > 
> > > Note, not tested against an actual bug, it looked wrong.
> > 
> > You are missing the CONFIG_THUMB2_KERNEL counterpart.
> 
> Sorry, I will have a look into that, although I may need
> some help on that as I don't have any experience with
> CONFIG_THUMB2_KERNEL or a userland to test with.

You don't need to change your userland.  The kernel may be compiled 
using the Thumb2 instruction set even if userland is traditional ARM 
mode.


Nicolas

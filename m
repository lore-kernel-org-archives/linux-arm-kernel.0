From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 13 Apr 2010 07:59:56 -0400 (EDT)
Subject: [RFC PATCH v5 0/2] ARM: VFP: Save / restore VFP state on the
	signal handler path
In-Reply-To: <20100413114218.GA22424@localhost>
References: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
	<cover.1270199787.git.imre.deak@nokia.com>
	<20100412220440.GF6148@shareable.org>
	<20100413114218.GA22424@localhost>
Message-ID: <alpine.LFD.2.00.1004130757350.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Apr 2010, Imre Deak wrote:

> On Tue, Apr 13, 2010 at 12:04:40AM +0200, ext Jamie Lokier wrote:
> > imre.deak at nokia.com wrote:
> > > From: Imre Deak <imre.deak@nokia.com>
> > > 
> > > Changes since v4:
> > > - Do not add the packed attribute to user_vfp or user_vfp_exc.
> > >   I added packed to these structs to prevent the extra padding in
> > >   vfp_sigframe. But actually the padding is in accordance with the
> > >   ARM ABI.
> > 
> > EABI, OABI or both?
> 
> I checked only EABI, which specifies alignment to the struct's alignment,
> which is 8 bytes for struct user_vfp.
> 
> I haven't found an official OABI spec, but some googling turned up
> that there the requirement is only to align to word size, so we'd
> have a difference in the struct vfp_sigframe's size and the alignment
> of the user_vfp_exc within.

I think that VFP is defined for EABI only anyway.  I doubt people are 
using VFP with OABI in practice either.


Nicolas

From: sarah.a.sharp@linux.intel.com (Sarah Sharp)
Date: Thu, 13 Feb 2014 16:09:10 -0800
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87wqh2iymx.fsf@natisbad.org>
References: <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
 <20140121211741.GA12657@xanatos> <87bnz364h0.fsf@natisbad.org>
 <20140122222641.GD29184@titan.lakedaemon.net>
 <87mwin4ozf.fsf@natisbad.org> <20140122235620.GC20359@xanatos>
 <87wqh2iymx.fsf@natisbad.org>
Message-ID: <20140214000910.GB16889@xanatos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 07:57:42PM +0100, Arnaud Ebalard wrote:
> Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> 
> > On Wed, Jan 22, 2014 at 11:43:16PM +0100, Arnaud Ebalard wrote:
> >> f5182b4155b9d686c5540a6822486400e34ddd98 "xhci: Disable MSI for some Fresco Logic hosts."
> >> 
> >> Technically, this is not per se the commit which introduced the
> >> regression but the one that *partially* fixed it by introducing the XHCI
> >> quirk to skip MSI enabling for Fresco Logic chips. The thing is it
> >> should have included the FL1009 in the targets. Sarah, can you confirm
> >> this?
> >
> > I don't know if it should have included FL1009, it was just a guess,
> > based on the fact that the 0x1000 and 0x1400 devices did need MSI
> > disabled.  I can attempt to ask the Fresco Logic folks I know, but I'm
> > not sure if/when I'll get a response back.
> >
> > That still doesn't necessarily rule out MSI issues in the Marvell PCI
> > host controller code.  Can you attach another PCI device with MSI
> > support under the host and see if it works?
> 
> Unless you have some objections or some positive feedback from Fresco
> Logic people, can you queue your quirks for FL1009 for 3.14-rc* and
> -stable? Note that I am just asking, i.e. if you want to wait a bit
> more, I am not that in a hurry.

Sorry for not getting back to you sooner.  The Fresco Logic folks said
that the FL1000 and FL1400 hosts are actually the same chipset, and it
doesn't support MSI.  However, they say the FL1009 *should* support MSI.

So that doesn't rule out issues with the Marvell PCI MSI code.  I
suspect that's actually the root cause, since I haven't gotten any bug
reports that the FL1009 doesn't work with MSI enabled on other systems.

Sarah Sharp

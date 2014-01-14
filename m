From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 14:01:29 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140114132319.GC28912@e102568-lin.cambridge.arm.com>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-4-git-send-email-broonie@kernel.org>
 <20140113164021.GA6934@e102568-lin.cambridge.arm.com>
 <20140113170156.GC29039@sirena.org.uk>
 <20140114101236.GA28912@e102568-lin.cambridge.arm.com>
 <20140114121343.GA15567@sirena.org.uk>
 <20140114132319.GC28912@e102568-lin.cambridge.arm.com>
Message-ID: <20140114140129.GI15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 01:23:19PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 14, 2014 at 12:13:43PM +0000, Mark Brown wrote:
> > On Tue, Jan 14, 2014 at 10:12:36AM +0000, Lorenzo Pieralisi wrote:
> > > On Mon, Jan 13, 2014 at 05:01:56PM +0000, Mark Brown wrote:

> > > > I would really have expected static data from a function marked init to
> > > > end up marked appropriately, but whatever.

> > > I would not expect that.

> > Really?  If something is local to a function marked init it seems like
> > the __init ought to carry over to it.

> Yes, for the same reason as static variables declared in a function do
> not end up in the .text section. You want the variable to be in the
> .init.data section and the compiler initialize it to 0 for you. If it was not
> declared as __initdata it would be added to the .bss section and zeroed
> by the kernel.

I understand why it might happen from an implementation point of view
but still not what I would expect to happen - I'd have expected that
annotations applied to a function would be able to automatically do the
right thing with their data.

> It is not the top frequency, it is the current frequency. Leaving the
> log is fine by me, but actually implies that the ePAPR must be followed,
> ie the property is "required".

Tweaking the semantics there was half the point of my patch (since
having the current frequency makes no sense in the context of FDT or
anything else without a running firmware), the other bit was just making
this more discoverable since while we say we're following ePAPR I don't
think anyone actually looks at it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/da87ecbb/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Feb 2014 23:46:10 +0900
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140226123208.GB22839@e102568-lin.cambridge.arm.com>
References: <1393302345-18253-1-git-send-email-broonie@kernel.org>
 <1393302345-18253-2-git-send-email-broonie@kernel.org>
 <20140225165411.GA3883@red-moon>
 <20140226005052.GA31120@sirena.org.uk>
 <20140226123208.GB22839@e102568-lin.cambridge.arm.com>
Message-ID: <20140226144610.GA2394@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 12:32:08PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Feb 26, 2014 at 12:50:52AM +0000, Mark Brown wrote:

> > Can I suggest that given the sort of thing we're looking at here it
> > might be easier to apply the code as-is and then do any further work
> > incrementally?

> I think we have enough information to make code complete now, at least
> for the topology code, I prefer to merge what's considered to be final.

Hrm, in that case perhaps the first patch is OK to go?  The changes
still being discussed are to the DT binding handling and the addition of
a new parsing mechanism (for MPIDR, which I'd do as a separate patch).
This would be quite helpful, tweaks to the first patch typically cause
manual rebases against the DT patches which increases the stop energy.

> > Having said that like I keep saying it seems most sensible to fall back
> > to MPIDR if we don't have any better idea; it's guaranteed to be
> > available, may well be correct and helps systems that did a good job
> > with their hardware.

> You have a point. Unless someone feels strongly against this, I would
> suggest falling back to MPIDR_EL1 if there is missing or wrong information in
> DT.

Catalin seemed very concerned about any use at all of MPIDR, that's why
the code was removed originally.  Catalin?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/940eb385/attachment.sig>

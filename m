From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 May 2014 16:18:16 +0100
Subject: [PATCH 1/2] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140522103550.GA24636@arm.com>
References: <1400545421-28067-1-git-send-email-broonie@kernel.org>
 <20140520173727.GD28293@arm.com>
 <alpine.LFD.2.11.1405201716460.17310@knanqh.ubzr>
 <20140522103550.GA24636@arm.com>
Message-ID: <20140522151816.GH12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 11:35:51AM +0100, Catalin Marinas wrote:
> On Tue, May 20, 2014 at 10:31:39PM +0100, Nicolas Pitre wrote:

> > It might be more productive to merge _something_ first, and doing so on 
> > the architecture side is certainly the least intrusive initial move.

> You are already renaming the arm arch_scale_freq_power(), why would you
> want to create more work for you by having to re-write parts of arm64 as
> well once you get to a consensus on scheduler changes?

> Just to be clear, I'm not against Mark's patch but I don't see any value
> in pushing it into mainline now, given that it is likely to be changed
> in the future following the work you and Vincent are doing.

Having the code in both ARMv7 and ARMv8 would mean that updating ARMv8
is mostly just typing rather than thinking which should make life
easier.  Any pain involved in the update is going to be felt updating
ARMv7 anyway, the additional difficulty in making the same update on
ARMv8 should be low if the code is in sync since the thinking part
applies equally well to both.

Not having the code there means there's that little bit more out of tree
code to keep in sync between the two architectures for testing updates
and that any generic improvements which happen to get implemented
without requiring architecture updates will need code writing for ARMv8
anyway.  At least some of the code is going to remain no matter what
parameters we end up passing to the scheduler.

If you are trying to save effort I think it's better to keep the two
architectures in sync as far as possible.  One other thing we could do
is move all the actual parameter setting to a separate patch so at least
the bit where we work out what cores we've got could go in.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/f90ee293/attachment.sig>

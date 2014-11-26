From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Nov 2014 16:18:02 +0000
Subject: [PATCHv6 6/8] arm64: use fixmap for text patching when text is RO
In-Reply-To: <5474D056.2050101@codeaurora.org>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
 <1416606645-25633-7-git-send-email-lauraa@codeaurora.org>
 <20141125170445.GB21525@leverpostej>
 <5474D056.2050101@codeaurora.org>
Message-ID: <20141126161802.GB1819@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 06:54:14PM +0000, Laura Abbott wrote:
> On 11/25/2014 9:04 AM, Mark Rutland wrote:
> > Hi Laura,
> >
> > It looks like "early" means before we've set up the strict page
> > permissions, though as far as I can tell the fixmap will already be
> > available before we do any patching. Could we not always use the fixmap
> > for patching? Then we only need the patch_{map,unmap} additions, and not
> > the changes to distinguish the early cases.
> >
> >  From testing on Juno with defconfig, all of the early patches were
> > avoidable NOP -> NOP changes as part of static key initialisation, which
> > I think we can skip similarly to x86 (I'll send a patch shortly). All other
> > patches were not early and went via the fixmap.
> >
> > Even with the avoidable NOP -> NOP patching I did not see a noticeable
> > boot time difference from forcing the use of the fixmap.
> >
> 
> I was basing it off of the arm version which needed the early option.
> If arm64 doesn't need it I'll drop it.

Given that it only determines whether or not to use the fixmap, and we
can always use the fixmap, I think we can drop it.

Thanks,
Mark.

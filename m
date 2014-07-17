From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 15:58:38 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <20140717145002.GW17528@sirena.org.uk>
References: <1405596402-23844-1-git-send-email-broonie@kernel.org>
 <20140717115937.GF18203@arm.com>
 <20140717145002.GW17528@sirena.org.uk>
Message-ID: <20140717145838.GJ18203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 03:50:02PM +0100, Mark Brown wrote:
> On Thu, Jul 17, 2014 at 12:59:38PM +0100, Catalin Marinas wrote:
> > On Thu, Jul 17, 2014 at 12:26:42PM +0100, Mark Brown wrote:
> 
> > > Commit 3efe33f5d2 (audit: x86: drop arch from __audit_syscall_entry()
> > > interface) removed the arch parameter from __audit_syscall_entry() and
> 
> > Thanks. This will have to be applied after 3.17-rc1 since commit
> > 3efe33f5d2 does not seem to be in mainline yet (nor the arm64 audit
> > patches).
> 
> That's not great and is kind of missing the point of -next - the core
> idea is to find these inter-tree dependencies, ensure things work when
> they're merged together and avoid things like massive bisection breaks.
> Leaving things also causes problems for anyone trying to do integration
> testing on -next.
> 
> What would be better would be if we could get the two trees synced up,
> in this case something like picking the audit change up in the ARMv8
> tree (or vice versa) seems like it'd be quick and easy since it looks
> like neither tree uses topic branches.

It's not ideal indeed but applying this patch on my tree would break it.
So we need a common base where the audit API is changed, guaranteed not
to be rebased so that I can merge it in the arm64 for-next/core branch.

Do you know which tree commit 3efe33f5d2 is in? I assume some tip
branch?

-- 
Catalin

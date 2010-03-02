From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 02 Mar 2010 09:58:36 +0000
Subject: [PATCH 0/4] ARM mandatory barriers
In-Reply-To: <63386a3d1003020150o6a7bf041mf9c32fb989430063@mail.gmail.com>
References: <20100223105806.11048.16585.stgit@e102109-lin.cambridge.arm.com>
	<63386a3d1003020150o6a7bf041mf9c32fb989430063@mail.gmail.com>
Message-ID: <1267523916.10368.8.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-02 at 09:50 +0000, Linus Walleij wrote:
> 2010/2/23 Catalin Marinas <catalin.marinas@arm.com>:
> 
> > This is a follow up to a previous patch I posted on the implementation
> > of the mandatory barriers on ARM. The third patch adds support for the
> > L2x0 cache sync operation and the last patch implements the
> > RealView-specific mandatory barriers.
> 
> Catalin what is the status of these patches? I don't find them in the
> patch tracker, are they being reworked? (Sorry if I missed some of the
> discussion here...)

They are being slightly reworked. The latest version is in my devel
branch (the top four patches currently):

http://linux-arm.org/git?p=linux-2.6.git;a=shortlog;h=refs/heads/devel

I think the main issue is whether the smp_mb() should be a DSB or a DMB.
Some drivers assume it's a DSB but this would have performance issues on
other usage models of this barrier where DMB would be enough.

I'll take this today to linux-arch for some clarification and I should
hopefully repost a new set of patches by the end of the week.

-- 
Catalin

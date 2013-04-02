From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 13:25:03 -0700
Subject: [GIT PULL] Renesas ARM SoC updates for v3.10 #2
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130402202503.GC8015@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 02:06:56PM +0900, Simon Horman wrote:
> Hi Arnd, Hi Olof,
> 
> The following changes since commit 4c82e452732784419fd616cf1acf2bc9b004aae1:
> 
>   Merge tag 'renesas-intc-external-irq2-for-v3.10' into soc-base (2013-04-02 10:55:57 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.10
> 
> for you to fetch changes up to 8585deb18580d04209a2986430aa0959ef38fce2:
> 
>   ARM: shmobile: r8a7790 SoC 64-bit DT support (2013-04-02 11:02:21 +0900)
> 
> ----------------------------------------------------------------
> Second round of Renesas ARM SoC updates for v3.10
> 
> Some Highlights:
> 
> * Add r8a7790 SoC
> * Add r8a73a4 SoC
> * Migrate r8a7740 SoC from INTC to GIC
> * Add thermal driver support to r8a73a4 SoC
> * Add irqpin DT nodes to sh73a0 SoC
> * Add SCIF support to r8a7778 SoC
> 
> This pull request is based on a merge of:
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-soc-for-v3.10
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-intc-external-irq2-for-v3.10

Ugh. So, the irq branch depends on the old soc branch, and now this depends on
the irq branch (and it is soc code). That's a circular dependency.

I'll add this as a next/soc2 branch in arm-soc, but please think about these
kind of circular dependencies in the future, and try to avoid them if you can
by splitting the branch contents in separate topics if possible.

Likewise, there's a bunch of patches in this branch such as the fixed divisor
clock patches that could be considered cleanup. Not a big deal to group them
with the soc code, but if you're already doing cleanup branches it'd be just as
well to put them in those.


-Olof

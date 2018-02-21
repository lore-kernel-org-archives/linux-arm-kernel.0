From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Feb 2018 17:47:19 +0000
Subject: [PATCH] arm64: Enforce BBM for huge IO/VMAP mappings
In-Reply-To: <20180221174423.tdqy43y64tcdzkmw@armageddon.cambridge.arm.com>
References: <1519217967-2545-1-git-send-email-will.deacon@arm.com>
 <20180221174423.tdqy43y64tcdzkmw@armageddon.cambridge.arm.com>
Message-ID: <20180221174718.GA3083@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 05:44:24PM +0000, Catalin Marinas wrote:
> On Wed, Feb 21, 2018 at 12:59:27PM +0000, Will Deacon wrote:
> > ioremap_page_range doesn't honour break-before-make and attempts to put
> > down huge mappings (using p*d_set_huge) over the top of pre-existing
> > table entries. This leads to us leaking page table memory and also gives
> > rise to TLB conflicts and spurious aborts, which have been seen in
> > practice on Cortex-A75.
> > 
> > Until this has been resolved, refuse to put block mappings when the
> > existing entry is found to be present.
> > 
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Reported-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Reported-by: Lei Li <lious.lilei@hisilicon.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Queued for 4.16. Shall we put a cc stable?

Yes, good idea:

Fixes: 324420bf91f60 ("arm64: add support for ioremap() block mappings")

Will

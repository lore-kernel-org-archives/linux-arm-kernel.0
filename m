From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Dec 2016 15:14:32 +0000
Subject: [PATCH] arm64: Re-enable PAN on uaccess_enable
In-Reply-To: <20161212150636.GA7070@cbox>
References: <1481550626-30956-1-git-send-email-marc.zyngier@arm.com>
 <20161212150636.GA7070@cbox>
Message-ID: <20161212151432.GB3203@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 04:06:36PM +0100, Christoffer Dall wrote:
> On Mon, Dec 12, 2016 at 01:50:26PM +0000, Marc Zyngier wrote:
> > Commit 4b65a5db3627 ("arm64: Introduce uaccess_{disable,enable}
> > functionality based on TTBR0_EL1") added conditional PAN
> > enable/disable. Unfortunately, a typo prevents PAN from being
> > re-enabled once it has been disabled.
> > 
> > Restore the PAN functionnality by adding the missing '!'.
> > 
> > Fixes: b65a5db3627 ("arm64: Introduce uaccess_{disable,enable} functionality based on TTBR0_EL1")
> > Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> > Christoffer, any chance you could give this a go and let me know
> > if that fixes your issues?
> 
> Yep, fixes the issue.  Thanks!

Thanks for confirming. I merged this with a slightly updated commit log:

------8<-----------------
Commit 4b65a5db3627 ("arm64: Introduce uaccess_{disable,enable}
functionality based on TTBR0_EL1") added conditional user access
enable/disable. Unfortunately, a typo prevents the PAN bit from being
cleared for user access functions.

-- 
Catalin

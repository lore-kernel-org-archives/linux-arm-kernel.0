From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Jan 2014 14:28:33 +0000
Subject: [PATCH] iommu/arm-smmu: change pud/pmd entry fill sequence
In-Reply-To: <1388750486-5060-1-git-send-email-yifan.zhangm@gmail.com>
References: <1388750486-5060-1-git-send-email-yifan.zhangm@gmail.com>
Message-ID: <20140106142833.GC10449@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 12:01:26PM +0000, Yifan Zhang wrote:
> From: Yifan Zhang <zhangyf@marvell.com>
> 
> Pgd/pud entry should be filled only once when their next level pud/pmd
> created, the value should be pud/pmd start address, while in current
> code, pgd/pud entry is filled every time when pud/pmd walk occurs,
> the value is pud/pmd start address + iova pud/pmd index , this is
> incorrect; Besides, when pud/pmd are created, we need to add pud/pmd
> index, then pass to next level, while in currect code, if a new pud/pmd
> created, their iova pud/pmd index is not taken into account, only
> existing pud/pmd do. This patch change pud/pmd entry fill sequence,
> fixes the 2 bugs.
> 
> Signed-off-by: Yifan Zhang <zhangyf@marvell.com>

Thanks Yifan, this looks good to me. It's strange that I got the pte
handling correct, but screwed up the equivalent pmd and pud code!

Will

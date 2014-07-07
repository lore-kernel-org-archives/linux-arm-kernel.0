From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Jul 2014 10:12:24 +0100
Subject: [PATCH v10 6/7] ARM: add pmd_[dirty|mkclean] for THP
In-Reply-To: <1404694438-10272-7-git-send-email-minchan@kernel.org>
References: <1404694438-10272-1-git-send-email-minchan@kernel.org>
 <1404694438-10272-7-git-send-email-minchan@kernel.org>
Message-ID: <20140707091223.GC3145@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 01:53:57AM +0100, Minchan Kim wrote:
> MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
> overwrite of the contents since MADV_FREE syscall is called for
> THP page.
> 
> This patch adds pmd_dirty and pmd_mkclean for THP page MADV_FREE
> support.

Looks fine to me, but it would be good if Steve can take a look too.

BTW: the subject of the patch says 'ARM:' but this only affects arm64. Is
there a corresponding patch for arch/arm/ too?

Will

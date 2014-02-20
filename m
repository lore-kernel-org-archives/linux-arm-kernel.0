From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Feb 2014 17:26:51 +0000
Subject: [RFC PATCH 2/2] arm: mm: Double logical invert for LPAE
 pte_write(), pte_dirty()
In-Reply-To: <1392396913-13570-3-git-send-email-steve.capper@linaro.org>
References: <1392396913-13570-1-git-send-email-steve.capper@linaro.org>
 <1392396913-13570-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20140220172651.GM3615@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 04:55:13PM +0000, Steve Capper wrote:
> On LPAE, L_PTE_WRITE and L_PTE_DIRTY are in the upper 32-bits.
> Unfortunately, results from pte_write() and pte_dirty() are downcast
> to 32-bits by core code:
>   o gather_stats
>   o huge_pte_dirty
>   o huge_pte_write
>   o make_migration_entry
> 
> This patch adds a double logical invert to pte_write() and pte_dirty()
> for LPAE to ensure that the lower 32-bits are set if true.

Yikes, this sounds like something we should put in -stable, no? If so,
better make it patch 1 of this series.

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will

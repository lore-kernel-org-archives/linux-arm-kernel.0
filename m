From: tj@kernel.org (Tejun Heo)
Date: Sun, 13 Oct 2013 14:02:27 -0400
Subject: [RFC 07/23] mm/memblock: debug: correct displaying of upper
 memory boundary
In-Reply-To: <1381615146-20342-8-git-send-email-santosh.shilimkar@ti.com>
References: <1381615146-20342-1-git-send-email-santosh.shilimkar@ti.com>
 <1381615146-20342-8-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131013180227.GD5253@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 12, 2013 at 05:58:50PM -0400, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> When debugging is enabled (cmdline has "memblock=debug") the memblock
> will display upper memory boundary per each allocated/freed memory range
> wrongly. For example:
>  memblock_reserve: [0x0000009e7e8000-0x0000009e7ed000] _memblock_early_alloc_try_nid_nopanic+0xfc/0x12c
> 
> The 0x0000009e7ed000 is displayed instead of 0x0000009e7ecfff
> 
> Hence, correct this by changing formula used to calculate upper memory
> boundary to (u64)base + size - 1 instead of  (u64)base + size everywhere
> in the debug messages.

I kinda prefer base + size because it's easier to actually know the
size but yeah, it should have been [base, base + size) and other
places use base + size - 1 notation so it probably is better to stick
to that.  Maybe move this one to the beginning of the series?

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

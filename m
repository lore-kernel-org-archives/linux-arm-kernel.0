From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 26 Feb 2013 14:12:46 +0530
Subject: [PATCH] ARM: mm: use phys_addr_t for physical address when
 populating pud
In-Reply-To: <1361805410-8664-1-git-send-email-will.deacon@arm.com>
References: <1361805410-8664-1-git-send-email-will.deacon@arm.com>
Message-ID: <512C7586.1020206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Monday 25 February 2013 08:46 PM, Will Deacon wrote:
> When creating our initial mappings, we call alloc_init_pud, which
> simply defers to alloc_init_section for mappings at the pmd level.
>
> However, the physical address passed to alloc_init_pud is potentially
> truncated to unsigned long, which could cause problems on systems making
> use of LPAE.
>
> This patch fixes the function prototype to use phys_addr_t.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
There is already a similar patch [1] on list which was suppose
to get merged in 3.9 from Cyril's series [2]

Regards,
Santosh

[1] https://lkml.org/lkml/2013/1/31/491
[2] http://www.spinics.net/lists/arm-kernel/msg221994.html

From: r.sricharan@ti.com (R Sricharan)
Date: Mon, 11 Feb 2013 18:26:22 +0530
Subject: [PATCH] ARM: LPAE: Fix mapping in alloc_init_section for unaligned
 addresses
In-Reply-To: <1360573733-12239-1-git-send-email-r.sricharan@ti.com>
References: <1360573733-12239-1-git-send-email-r.sricharan@ti.com>
Message-ID: <5118EA76.4050106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> With LPAE enabled, alloc_init_section() does not map the entire
> address space for unaligned addresses.
>
> The issue also reproduced with CMA + LPAE. CMA tries to map 16MB
> with page granularity mappings during boot. alloc_init_pte()
> is called and out of 16MB, only 2MB gets mapped and rest remains
> unaccessible.
>
> Because of this OMAP5 boot is broken with CMA + LPAE enabled.
> Fix the issue by ensuring that the entire addresses are
> mapped.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <chris@cloudcar.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>   [V2] Moved the loop to alloc_init_pte as per Russell's
>       feedback and changed the subject accordingly.
>       Using PMD_XXX instead of SECTION_XXX to avoid
>       different loop increments with/without LPAE.
>
>   [v3] Removed the dummy variable phys and updated
>        the commit log for CMA case.
>
>   [v4] Resending with updated change log and
>        updating the tags.
>
>   [v5] Renamed alloc_init_section to alloc_init_pmd
>        and moved the loop back there. Also introduced
>        map_init_section as per Catalin's comments.
>
>   [v6] Corrected tags and updated the comments for code.
>
  Please discard this. Missed "V6" in subject.
  Sent one more with proper subject.

Regards,
  Sricharan

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 Feb 2013 15:21:52 +0000
Subject: [PATCH V5] ARM: LPAE: Fix mapping in alloc_init_section for
 unaligned addresses
In-Reply-To: <1360323019-30139-1-git-send-email-r.sricharan@ti.com>
References: <1360323019-30139-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20130208152152.GA2122@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 11:30:18AM +0000, R Sricharan wrote:
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
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Christoffer Dall <chris@cloudcar.com>

The code looks fine but you need to fix the comments as per
Christoffer's suggestion. Otherwise:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

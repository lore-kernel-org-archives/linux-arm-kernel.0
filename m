From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Sep 2015 16:27:48 +0100
Subject: [PATCH] arm64: ioremap: change ioremap prototype and add
 ioremap_cache macro
In-Reply-To: <1440663660-24244-1-git-send-email-yalin.wang2010@gmail.com>
References: <1440663660-24244-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <20150904152748.GB23159@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 04:21:00PM +0800, yalin wang wrote:
> This patch change ioremap_*() first parameter type to resource_size_t to
> be the same as other platforms, and add ioremap_cache macro,
> because some code will test if this macro is defined or not, and
> will generate a generric version if not defined, for example,
> memremap.c do like this.

It seems that asm-generic/io.h uses phys_addr_t (which makes more sense
to me, though they are practically the same).

> +#define ioremap_cache			ioremap_cache

This makes sense.

-- 
Catalin

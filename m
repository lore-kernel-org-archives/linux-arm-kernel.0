From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Jul 2014 17:24:23 +0100
Subject: [PATCH v2 2/3] ARM: Use include/asm-generic/io.h
In-Reply-To: <1405092672-18549-2-git-send-email-thierry.reding@gmail.com>
References: <1405092672-18549-1-git-send-email-thierry.reding@gmail.com>
 <1405092672-18549-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140711162422.GF16321@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 04:31:11PM +0100, Thierry Reding wrote:
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index a78562f21aab..ef54f5c8a7ae 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
[...]
> -#define iowrite16be(v,p) ({ __iowmb(); __raw_writew((__force __u16)cpu_to_be16(v), p); })
> -#define iowrite32be(v,p) ({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })

Aren't you losing the barrier semantics here? The generic iowrite*be()
functions call __raw_write*() directly which don't have a barrier
(write* accessors do).

-- 
Catalin

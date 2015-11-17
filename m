From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Nov 2015 13:24:28 +0000
Subject: [PATCH] ARM64: do not include ptrace.h from compat.h
In-Reply-To: <4870233.DUFZXD30Rq@wuerfel>
References: <4870233.DUFZXD30Rq@wuerfel>
Message-ID: <20151117132428.GI6556@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 05:32:15PM +0100, Arnd Bergmann wrote:
> including ptrace.h brings a definition of BITS_PER_PAGE into device
> drivers and cause a build warning in allmodconfig builds:
> 
> drivers/block/drbd/drbd_bitmap.c:482:0: warning: "BITS_PER_PAGE" redefined
>  #define BITS_PER_PAGE  (1UL << (PAGE_SHIFT + 3))
> 
> This uses a slightly different way to express current_pt_regs()
> that avoids the use of the header and gets away with the already
> included asm/ptrace.h.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied. Thanks.

-- 
Catalin

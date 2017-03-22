From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Mar 2017 14:37:29 +0000
Subject: [PATCH] [v2] arm64: define BUG() instruction without CONFIG_BUG
In-Reply-To: <20170314213939.3874497-1-arnd@arndb.de>
References: <20170314213939.3874497-1-arnd@arndb.de>
Message-ID: <20170322143729.GB25645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Mar 14, 2017 at 10:39:21PM +0100, Arnd Bergmann wrote:
> This mirrors commit e9c38ceba8d9 ("ARM: 8455/1: define __BUG as
> asm(BUG_INSTR) without CONFIG_BUG") to make the behavior of
> arm64 consistent with arm and x86, and avoids lots of warnings in
> randconfig builds, such as:
> 
> kernel/seccomp.c: In function '__seccomp_filter':
> kernel/seccomp.c:666:1: error: no return statement in function returning non-void [-Werror=return-type]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

A side-effect of this patch is that it turns WARN into BUG. I hit the
WARN_ONCE in arch/arm64/kernel/efi.c:34 (on Juno with 64K pages) and
with your patch applied, the kernel panics.

-- 
Catalin

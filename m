From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Fri, 16 Oct 2015 23:46:29 +0300
Subject: [PATCH] ARM: thp: fix unterminated ifdef in header file
In-Reply-To: <5446974.UXhT00HeJk@wuerfel>
References: <5446974.UXhT00HeJk@wuerfel>
Message-ID: <20151016204629.GA1817@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 10:02:04PM +0200, Arnd Bergmann wrote:
> A recent change accidentally removed one line more than it should
> have, causing the build to fail with ARM LPAE:
> 
> In file included from /git/arm-soc/arch/arm/include/asm/pgtable.h:31:0,
>                  from /git/arm-soc/include/linux/mm.h:55,
>                  from /git/arm-soc/arch/arm/kernel/asm-offsets.c:15:
> /git/arm-soc/arch/arm/include/asm/pgtable-3level.h:20:0: error: unterminated #ifndef
>  #ifndef _ASM_PGTABLE_3LEVEL_H
> 
> This puts the line back where it was.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: f054144a1b23 ("arm, thp: remove infrastructure for handling splitting PMDs")

Sorry.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

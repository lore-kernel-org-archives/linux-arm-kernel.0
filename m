From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 15:10:05 +0000
Subject: [PATCHv2 01/18] asm-generic: make __set_fixmap_offset a static
 inline
In-Reply-To: <1451930211-22460-2-git-send-email-mark.rutland@arm.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <1451930211-22460-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20160128151004.GH775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 05:56:34PM +0000, Mark Rutland wrote:
> Currently __set_fixmap_offset is a macro function which has a local
> variable called 'addr'. If a caller passes a 'phys' parameter which is
> derived from a variable also called 'addr', the local variable will
> shadow this, and the compiler will complain about the use of an
> uninitialized variable.
> 
> It is likely that fixmap users may use the name 'addr' for variables
> that may be directly passed to __set_fixmap_offset, or that may be
> indirectly generated via other macros. Rather than placing the burden on
> callers to avoid the name 'addr', this patch changes __set_fixmap_offset
> into a static inline function, avoiding namespace collisions.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  include/asm-generic/fixmap.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can pick this up for 4.6 along with Arnd's ack.

Will

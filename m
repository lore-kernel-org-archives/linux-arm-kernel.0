From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Jun 2017 16:49:39 +0100
Subject: [PATCH] arm64: pass machine size to sparse
In-Reply-To: <20170620122443.35880-1-luc.vanoostenryck@gmail.com>
References: <20170620122443.35880-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170620154938.GH21131@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 02:24:43PM +0200, Luc Van Oostenryck wrote:
> When using sparse on the arm64 tree we get many thousands of
> warnings like 'constant ... is so big it is unsigned long long'
> or 'shift too big (32) for type unsigned long'. This happens
> because by default sparse considers the machine as 32bit and
> defines the size of the types accordingly.
> 
> Fix this by passing the '-m64' flag to sparse so that
> sparse can correctly define longs as being 64bit.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index f839ecd91..15d6c1476 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -62,7 +62,7 @@ LD		+= -EL
>  UTS_MACHINE	:= aarch64
>  endif
>  
> -CHECKFLAGS	+= -D__aarch64__
> +CHECKFLAGS	+= -D__aarch64__ -m64

Looks fine to me, but just wondering whether or not we should also be
passing something to indicate the endianness of the target. Does sparse care
about that?

Will

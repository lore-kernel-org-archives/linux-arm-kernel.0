From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Aug 2013 23:45:52 +0100
Subject: [PATCH] ARM: LLVMLinux: Change "extern inline" to "gnu_inline"
 in ARM ftrace.h
In-Reply-To: <1376516261-2071-2-git-send-email-behanw@converseincode.com>
References: <1376516261-2071-1-git-send-email-behanw@converseincode.com>
 <1376516261-2071-2-git-send-email-behanw@converseincode.com>
Message-ID: <20130814224552.GA23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 05:37:41PM -0400, behanw at converseincode.com wrote:
> From: Mark Charlebois <charlebm@gmail.com>
> 
> With compilers which follow the C99 standard (like modern versions of gcc and
> clang), "extern inline" does the wrong thing (emits code for an externally
> linkable version of the inline function). In this case using the gnu_inline
> attribute makes inline do the right thing on gcc and on clang.
> 
> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> ---
>  arch/arm/include/asm/ftrace.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index f89515a..fb7fdc4 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -45,7 +45,8 @@ void *return_address(unsigned int);
>  
>  #else
>  
> -extern inline void *return_address(unsigned int level)
> +extern inline __attribute__((gnu_inline))
> +void *return_address(unsigned int level)

Well, that should be static inline, not extern inline in any case.  Does
clang work if that's static inline?

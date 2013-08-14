From: joe@perches.com (Joe Perches)
Date: Wed, 14 Aug 2013 14:56:10 -0700
Subject: [PATCH] ARM: LLVMLinux: Change "extern inline" to "gnu_inline"
 in ARM ftrace.h
In-Reply-To: <1376516261-2071-2-git-send-email-behanw@converseincode.com>
References: <1376516261-2071-1-git-send-email-behanw@converseincode.com>
 <1376516261-2071-2-git-send-email-behanw@converseincode.com>
Message-ID: <1376517370.1949.115.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-14 at 17:37 -0400, behanw at converseincode.com wrote:
> From: Mark Charlebois <charlebm@gmail.com>
> 
> With compilers which follow the C99 standard (like modern versions of gcc and
> clang), "extern inline" does the wrong thing (emits code for an externally
> linkable version of the inline function). In this case using the gnu_inline
> attribute makes inline do the right thing on gcc and on clang.

Why not convert these to static inline?

> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
[]
> @@ -45,7 +45,8 @@ void *return_address(unsigned int);
>  
>  #else
>  
> -extern inline void *return_address(unsigned int level)
> +extern inline __attribute__((gnu_inline))
> +void *return_address(unsigned int level)
>  {
>  	return NULL;
>  }

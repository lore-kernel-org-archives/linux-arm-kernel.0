From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 May 2012 02:24:50 +0100
Subject: [RFC PATCH] ARM: cmpxchg: define __HAVE_ARCH_CMPXCHG for armv6
 and later
In-Reply-To: <1338364287-11614-1-git-send-email-yong.zhang0@gmail.com>
References: <1338364287-11614-1-git-send-email-yong.zhang0@gmail.com>
Message-ID: <20120531012450.GA8506@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, May 30, 2012 at 08:51:26AM +0100, Yong Zhang wrote:
> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index 7eb18c1..a91b44e 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -127,6 +127,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>  
>  #else	/* min ARCH >= ARMv6 */
>  
> +#define __HAVE_ARCH_CMPXCHG 1
> +
>  extern void __bad_cmpxchg(volatile void *ptr, int size);

As long as this only requires 4-byte cmpxchg support then I think this is
fine. It looks like that's currently the case, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

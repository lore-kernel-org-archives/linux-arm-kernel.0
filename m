From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Sep 2014 12:11:04 +0200
Subject: [PATCH 08/24] Allow a 32bit ABI to use the naming of the 64bit
 ABI syscalls to avoid confusion of not splitting the registers
In-Reply-To: <1409779158-30963-9-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-9-git-send-email-apinski@cavium.com>
Message-ID: <3318813.yqP9pCQtAB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 14:19:02 Andrew Pinski wrote:
> + * For 32bit abis where 64bit can be passed via one
> + * register, use the same naming as the 64bit ones
> + * as they will only have a 64 bit off_t.
>   */
> -#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
> +#if (__BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)) || \
> +       defined(__ARCH_WANT_64BIT_SYSCALLS)
> 

I'm not sure if __ARCH_WANT_64BIT_SYSCALLS is the best name for
this, since it's really only about off_t. It took me a while
to understand what you are doing here.

	Arnd

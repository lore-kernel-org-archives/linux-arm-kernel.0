From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 18:44:21 +0200
Subject: [PATCH v2 3/3] ARM: pxa/pj4: Port problematic pj4 support code to
	v7/Thumb-2
In-Reply-To: <1315497854-13311-4-git-send-email-dave.martin@linaro.org>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-4-git-send-email-dave.martin@linaro.org>
Message-ID: <201109081844.21371.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011, Dave Martin wrote:
>         __asm__ __volatile__ (
>                 "mcr    p15, 0, %1, c1, c0, 2\n\t"
> +#ifdef __LINUX_ARM_ARCH__ >= 7
> +               "isb\n\t"
> +#else
>                 "mrc    p15, 0, %0, c1, c0, 2\n\t"
>                 "mov    %0, %0\n\t"
>                 "sub    pc, pc, #4\n\t"
> +#endif
>                 : "=r" (temp) : "r" (value));
>  }

I thought we had concluded that we don't actually need the #else
path because there is no pre-v7 support for pj4 any more.

	Arnd

From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 4 Oct 2011 08:59:56 +0800
Subject: [PATCH 16/26] ARM: pxa: CPU_PJ4 requires IWMMXT
In-Reply-To: <20295619.jOfPxmug8T@wuerfel>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-17-git-send-email-arnd@arndb.de>
	<20111002160328.GZ11710@n2100.arm.linux.org.uk>
	<20295619.jOfPxmug8T@wuerfel>
Message-ID: <CAMPhdO96WwmPVqVpM2Vpef3wSgfHEf-0tK5VewXn-EGMns2ubA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 8<-----
> Subject: [PATCH] ARM: pxa: CPU_PJ4 requires IWMMXT
>
> The PJ4 based pxa95x cpus all have iwmmxt and there is no way to
> build that code conditionally, so better not ask the user
> in that configuration, in order to prevent broken builds.

I think this is true for other xscale CPUs as well, so either we make
them unconditionally all at once, or we still leave an option here.

It actually looks quite odd to me that CPU_PJ4 is made special here,
what're the real broken builds errors?

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5ebc5d9..8d66c32 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1071,9 +1071,10 @@ config ARM_TIMER_SP804
> ?source arch/arm/mm/Kconfig
>
> ?config IWMMXT
> - ? ? ? bool "Enable iWMMXt support"
> + ? ? ? bool "Enable iWMMXt support" if !CPU_PJ4
> ? ? ? ?depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
> ? ? ? ?default y if PXA27x || PXA3xx || PXA95x || ARCH_MMP
> + ? ? ? default y if CPU_PJ4
> ? ? ? ?help
> ? ? ? ? ?Enable support for iWMMXt context switching at run time if
> ? ? ? ? ?running on a CPU that supports it.
>

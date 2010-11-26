From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Fri, 26 Nov 2010 12:57:02 +0100
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <AANLkTikkVqWgpYEg505DwQ+pSegQv1g-Q8cDEpE-JCrV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/20 Hans Ulli Kroll <ulli.kroll@googlemail.com>:
> Add support for PCI Bus on Gemini Devices SL3516
>
> Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> ---
[...]
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a19a526..5d4b398 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -307,6 +307,7 @@ config ARCH_GEMINI
> ? ? ? ?select CPU_FA526
> ? ? ? ?select ARCH_REQUIRE_GPIOLIB
> ? ? ? ?select ARCH_USES_GETTIMEOFFSET
> + ? ? ? select PCI
> ? ? ? ?help
> ? ? ? ? ?Support for the Cortina Systems Gemini family SoCs
>
[...]

I think it's better to add ARCH_GEMINI to CONFIG_PCI dependencies.
AFAIK IB-4220B NAS does not use PCI and doesn't need all that code.
Board support entries could select PCI if the board is useless without
it.

Best Regards,
Micha? Miros?aw

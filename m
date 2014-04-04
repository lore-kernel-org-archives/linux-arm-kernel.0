From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 04 Apr 2014 07:57:36 -0700
Subject: [PATCH v1 6/8] ARM: hisi: add hip04 SoC support
In-Reply-To: <1396339430-21084-7-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Tue, 1 Apr 2014 16:03:48 +0800")
References: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
 <1396339430-21084-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <7hd2gxywf3.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
> Cortex A15 Core. And HiP04 supports LPAE to support large memory.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

[...]

> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> index da16efd..707abfe 100644
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -19,6 +19,16 @@ config ARCH_HI3xxx
>  	help
>  	  Support for Hisilicon Hi36xx/Hi37xx processor family
>  
> +config ARCH_HIP04
> +	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
> +	select ARM_LPAE

Presumably this SoC can support non-LPAE also, correct?  If so, LPAE
should't be selected here, or else it will force LPAE on in a multi_v7
build also.

Also, please run this patch through scripts/checkpatch.pl and fix the
issues reported there.

Kevin

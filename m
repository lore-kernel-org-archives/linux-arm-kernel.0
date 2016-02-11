From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 23:12:18 +0100
Subject: [PATCH v2 1/3] of/fdt: factor out assignment of
 initrd_start/initrd_end
In-Reply-To: <1455209282-9596-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455209282-9596-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <3591081.dypcHcG82d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 February 2016 17:48:00 Ard Biesheuvel wrote:
> 
>  #ifdef CONFIG_BLK_DEV_INITRD
> +void __weak __early_init_dt_declare_initrd(unsigned long start,
> +                                          unsigned long end)
> +{
> +       initrd_start = (unsigned long)__va(start);
> +       initrd_end = (unsigned long)__va(end);
> +       initrd_below_start_ok = 1;
> +}
> +
> 

I find __weak functions particularly hard to follow, I think a Kconfig
symbols or a function you can override by defining a macro in asm/memory.h
would be nicer.

	Arnd

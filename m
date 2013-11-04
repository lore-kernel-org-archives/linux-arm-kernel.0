From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon, 04 Nov 2013 10:15:40 +0100
Subject: [PATCH] ARM: S3C24XX: remove unused Kconfig parameter
In-Reply-To: <1383463529-3113-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1383463529-3113-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <527765BC.5010904@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2013 08:25 AM, Michael Opdenacker wrote:
> This removes the MACH_S3C2413 Kconfig parameter,
> which was no longer used anywhere in the source code
> and Makefiles.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> ---
>  arch/arm/mach-s3c24xx/Kconfig | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index dba2173e70f3..9d90dd06cf2f 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -415,13 +415,6 @@ config MACH_JIVE_SHOW_BOOTLOADER
>  	bool "Allow access to bootloader partitions in MTD"
>  	depends on MACH_JIVE
>  
> -config MACH_S3C2413
> -	bool
> -	help
> -	  Internal node for S3C2413 version of SMDK2413, so that
> -	  machine_is_s3c2413() will work when MACH_SMDK2413 is
> -	  selected
> -
>  config MACH_SMDK2412
>  	bool "SMDK2412"
>  	select MACH_SMDK2413

Actually, in another thread, Sascha Hauer made me realize that this
symbol is actually used to make machine_is_s3c2413() become true when
the kernel is started with the corresponding machine id.

However, this patch doesn't hurt as machine_is_s3c2413() isn't used in
the code.

You can either keep it or wait for s3c2413 support to be removed or to
be converted to the device tree.

Cheers,

Michael.

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098

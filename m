From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Sun, 12 Feb 2012 14:57:17 +0100
Subject: [PATCH] ARM: s3c2440: fix undefined reference to
 `s3c2440_restart' for machine gta02
In-Reply-To: <1329051929-8303-1-git-send-email-GNUtoo@no-log.org>
References: <1329051929-8303-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <201202121457.18632.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

Am Sonntag 12 Februar 2012, 14:05:29 schrieb Denis 'GNUtoo' Carikli:
> Without that fix we have(when compiling for the gta02 machine):
>     LD      .tmp_vmlinux1
>   arch/arm/mach-s3c2440/built-in.o:(.arch.info.init+0x3c): undefined
> reference to `s3c2440_restart' make: *** [.tmp_vmlinux1] Error 1
> 
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
> ---
>  arch/arm/mach-s3c2440/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
> index 914e620..d8c8ad7 100644
> --- a/arch/arm/mach-s3c2440/Kconfig
> +++ b/arch/arm/mach-s3c2440/Kconfig
> @@ -89,6 +89,7 @@ config MACH_ANUBIS
>  config MACH_NEO1973_GTA02
>  	bool "Openmoko GTA02 / Freerunner phone"
>  	select CPU_S3C2442
> +	select CPU_S3C2440
>  	select MFD_PCF50633
>  	select PCF50633_GPIO
>  	select I2C
wouldn't moving the restart function to common code be better than selecting a 
cpu that is not used?

I've also added the relevant maintainers to the mail.

Heiko

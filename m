From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 29 Nov 2010 19:51:56 +0900
Subject: [PATCH 01/10] SMDK2416: Select MACH_SMDK, S3C_DEV_NAND,
	S3C_DEV_USB_HOST
In-Reply-To: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
Message-ID: <000e01cb8fb3$73666740$5a3335c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> Enable compilation of platform devices and initialization code used in
> SMDK2416 board file.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  arch/arm/mach-s3c2416/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> index 87b9c9f..27b3e7c 100644
> --- a/arch/arm/mach-s3c2416/Kconfig
> +++ b/arch/arm/mach-s3c2416/Kconfig
> @@ -35,9 +35,12 @@ menu "S3C2416 Machines"
>  config MACH_SMDK2416
>  	bool "SMDK2416"
>  	select CPU_S3C2416
> +	select MACH_SMDK

No need to add this here.
According to mach-s3c2416/Kconfig, CPU_S3C2416 depends on ARCH_S3C2410.
Actually only selected it when selected ARCH_S3C24XX...

But I think need to sort out selection for S3C24XX in Kconfig.

>  	select S3C_DEV_FB
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC1
> +	select S3C_DEV_NAND
> +	select S3C_DEV_USB_HOST

Probably, did you test NAND and USB_HOST on board?

>  	select S3C2416_PM if PM
>  	help
>  	  Say Y here if you are using an SMDK2416
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

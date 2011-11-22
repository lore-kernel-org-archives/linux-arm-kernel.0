From: joe@perches.com (Joe Perches)
Date: Mon, 21 Nov 2011 17:24:17 -0800
Subject: [PATCH] ARM: mx5: Fix checkpatch warnings in cpu-imx5.c
In-Reply-To: <1321900012-8351-2-git-send-email-fabio.estevam@freescale.com>
References: <1321900012-8351-1-git-send-email-fabio.estevam@freescale.com>
 <1321900012-8351-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1321925057.1131.2.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-21 at 16:26 -0200, Fabio Estevam wrote:
> WARNING: line over 80 characters

Trivia...

> #70: FILE: arm/mach-imx/cpu-imx5.c:70:
> +	if (mx51_revision() < IMX_CHIP_REVISION_3_0 && (elf_hwcap & HWCAP_NEON)) {
[]
> diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
[]
> @@ -67,7 +67,8 @@ static int __init mx51_neon_fixup(void)
>  	if (!cpu_is_mx51())
>  		return 0;
>  
> -	if (mx51_revision() < IMX_CHIP_REVISION_3_0 && (elf_hwcap & HWCAP_NEON)) {
> +	if (mx51_revision() < IMX_CHIP_REVISION_3_0 &&
> +					(elf_hwcap & HWCAP_NEON)) {
>  		elf_hwcap &= ~HWCAP_NEON;
>  		pr_info("Turning off NEON support, detected broken NEON implementation\n");
>  	}

Perhaps more readable as:

	if (elf_hwcap & HWCAP_NEON &&
	    mx51_revision() < IMX_CIP_REVISION_3_0) {
		elf_hwcap &= ~HWCAP_NEON;
		etc...
		

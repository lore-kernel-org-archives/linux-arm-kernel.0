From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 1 Dec 2011 10:50:02 +0100
Subject: [PATCH] ARM: Kota2 mach-type update fix
In-Reply-To: <20111122060857.23951.50598.sendpatchset@w520>
References: <20111122060857.23951.50598.sendpatchset@w520>
Message-ID: <201112011050.02877.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2011, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch adds kota2 to the in-kernel ARM mach-type file.
> 
> Basic board support is included in 3.2-rc and the mach-type
> has been registered in the ARM machine repository as
> 
> 3616 Renesas SH-Mobile kota2.x Board kota2 Yusuke Goda mainlined
> 
> The file arch/arm/tools/mach-types is however missing Kota2
> which makes build of sh73a0 based boards fail with:
> 
> arch/arm/mach-shmobile/platsmp.c: In function 'shmobile_smp_get_core_count':
> arch/arm/mach-shmobile/platsmp.c:28:2: error: implicit declaration of function 'machine_is_kota2'
> make[1]: *** [arch/arm/mach-shmobile/platsmp.o] Error 1
> 
> arch/arm/mach-shmobile/board-kota2.c:448:136: error: 'MACH_TYPE_KOTA2' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-shmobile/board-kota2.o] Error 1
> make: *** [arch/arm/mach-shmobile] Error 2
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

This patch is necessary to fix build of the Linus' tree for me with both
CONFIG_ARCH_SH73A0 and CONFIG_SMP set.

Tested-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks,
Rafael


> ---
> 
>  I propose that Paul Mundt merges this patch together with other
>  SH-Mobile ARM related fixes.
> 
>  arch/arm/tools/mach-types |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 0001/arch/arm/tools/mach-types
> +++ work/arch/arm/tools/mach-types	2011-11-14 16:55:38.000000000 +0900
> @@ -1123,5 +1123,6 @@ blissc			MACH_BLISSC		BLISSC			3491
>  thales_adc		MACH_THALES_ADC		THALES_ADC		3492
>  ubisys_p9d_evp		MACH_UBISYS_P9D_EVP	UBISYS_P9D_EVP		3493
>  atdgp318		MACH_ATDGP318		ATDGP318		3494
> +kota2			MACH_KOTA2		KOTA2			3616
>  smdk4212		MACH_SMDK4212		SMDK4212		3638
>  smdk4412		MACH_SMDK4412		SMDK4412		3765
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

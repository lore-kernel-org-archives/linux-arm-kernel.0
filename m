From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 21:35:23 +0900
Subject: [PATCH v2 4/5] ARM: S5PV210: add DMCx access virtual address
In-Reply-To: <1279267277-6804-5-git-send-email-myungjoo.ham@samsung.com>
References: <1279267277-6804-1-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-2-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-3-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-4-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-5-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <013001cb24e3$5ec9ca10$1c5d5e30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> This patch prepares CPUFREQ support for S5PV210 by adding definitions
> for S5P_VA_DMCx accessed by CPUFREQ, which were not defined previously.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/cpu.c              |   12 +++++++++++-
>  arch/arm/mach-s5pv210/include/mach/map.h |    8 ++++++++
>  2 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> index 94c632b..84a6708 100644
> --- a/arch/arm/mach-s5pv210/cpu.c
> +++ b/arch/arm/mach-s5pv210/cpu.c
> @@ -59,7 +59,17 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
>  		.pfn		= __phys_to_pfn(S5PV210_PA_SROMC),
>  		.length		= SZ_4K,
>  		.type		= MT_DEVICE,
> -	}
> +	}, {
> +		.virtual    = (unsigned long)S5P_VA_DMC0,
> +		.pfn        = __phys_to_pfn(S5P_PA_DMC0),
> +		.length     = SZ_4K,
> +		.type       = MT_DEVICE,
> +	}, {
> +		.virtual    = (unsigned long)S5P_VA_DMC1,
> +		.pfn        = __phys_to_pfn(S5P_PA_DMC1),
> +		.length     = SZ_4K,
> +		.type       = MT_DEVICE,
> +	},
>  };
> 
>  static void s5pv210_idle(void)
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> s5pv210/include/mach/map.h
> index 17687f0..4945674 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -108,4 +108,12 @@
>  #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
>  #define SAMSUNG_PA_KEYPAD	S5PV210_PA_KEYPAD
> 
> +/* DMC */
> +#define S5P_PA_DMC0     (0xF0000000)

Should be S5PV210_PA_DMC0..
If you need to define S5P_PA_xxx, you can re-define like others in here.
But right now no need S5P_PA_xxx because used in cpu.c of mach directory not
plat-s5p.

> +#define S5P_VA_DMC0     S3C_ADDR(0x00a00000)

If you need to add VA_xxx, should be in plat-s5p/include/plat/map-s5p.h

> +
> +#define S5P_PA_DMC1     (0xF1400000)
> +#define S5P_VA_DMC1     S3C_ADDR(0x00b00000)

Same...

> +
> +

No need 2 empty lines...1 empty line is enough.

>  #endif /* __ASM_ARCH_MAP_H */
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

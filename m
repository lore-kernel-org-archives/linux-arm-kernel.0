From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 04 Aug 2010 20:17:50 +0900
Subject: [PATCH v6 5/7] ARM: S5PV210: Access for DMCx registers
In-Reply-To: <1280829866-26001-6-git-send-email-myungjoo.ham@samsung.com>
References: <1280829866-26001-1-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-2-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-3-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-4-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-5-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-6-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <001901cb33c6$b05542f0$10ffc8d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> 	The CPUFREQ driver requires an access to DMCx registers. We
> define physical addresses and mapping between physical and virtual
> addresses of DMCx registers.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/cpu.c              |   12 +++++++++++-
>  arch/arm/mach-s5pv210/include/mach/map.h |    4 ++++
>  2 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> index 74d4c08..2066695 100644
> --- a/arch/arm/mach-s5pv210/cpu.c
> +++ b/arch/arm/mach-s5pv210/cpu.c
> @@ -60,7 +60,17 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
>  		.pfn		= __phys_to_pfn(S5PV210_PA_SROMC),
>  		.length		= SZ_4K,
>  		.type		= MT_DEVICE,
> -	}
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_DMC0,
> +		.pfn		= __phys_to_pfn(S5PV210_PA_DMC0),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_DMC1,
> +		.pfn		= __phys_to_pfn(S5PV210_PA_DMC1),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	},
>  };
> 
>  static void s5pv210_idle(void)
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> s5pv210/include/mach/map.h
> index 17687f0..daf6456 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -108,4 +108,8 @@
>  #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
>  #define SAMSUNG_PA_KEYPAD	S5PV210_PA_KEYPAD
> 
> +/* DMC */

No need an obvious comment like above...

> +#define S5PV210_PA_DMC0		(0xF0000000)
> +#define S5PV210_PA_DMC1		(0xF1400000)

As I said, if you need adding new definition into the mach/map.h, please
keep the address order like others.
It can help to us for easily reading...

> +
>  #endif /* __ASM_ARCH_MAP_H */
> --

And as I commented, to merge your 4th(previous, just adding VA) and 5th
patch to one is better...just for adding DMC map IO.


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

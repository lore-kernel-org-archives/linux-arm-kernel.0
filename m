From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 29 Jul 2010 15:11:20 +0400
Subject: [PATCH v5 3/7] ARM: S5P: Added default pll values for APLL
	800/1000MHz
In-Reply-To: <1280399145-22761-4-git-send-email-myungjoo.ham@samsung.com>
References: <1280399145-22761-1-git-send-email-myungjoo.ham@samsung.com>	<1280399145-22761-2-git-send-email-myungjoo.ham@samsung.com>	<1280399145-22761-3-git-send-email-myungjoo.ham@samsung.com>
	<1280399145-22761-4-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <4C5161D8.1010609@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

MyungJoo Ham wrote:

> CPUFREQ of S5PV210 uses different APLL settings according to
> different CPU frequencies. We provide such settings values for
> CPUFREQ at pll.h.

> Note that at 1GHz of ARMCLK, APLL should be 1GHz and for other lower
> ARMCLK, APLL should be 800MHz.

> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
[...]
> diff --git a/arch/arm/plat-s5p/include/plat/pll.h b/arch/arm/plat-s5p/include/plat/pll.h
> index 7db3227..d79042a 100644
> --- a/arch/arm/plat-s5p/include/plat/pll.h
> +++ b/arch/arm/plat-s5p/include/plat/pll.h
> @@ -21,6 +21,9 @@
>  
>  #include <asm/div64.h>
>  
> +#define PLL45XX_APLL_VAL_1000	((1 << 31) | (125<<16) | (3<<8) | (1))
> +#define PLL45XX_APLL_VAL_800	((1 << 31) | (100<<16) | (3<<8) | (1))
> +

   Incosistent spacing. Why there spaces around the first << but not around 
the following? Should be spaces around every <<...


WBR, Sergei

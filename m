From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 26 Apr 2015 11:13:13 +0300
Subject: [PATCH] arm: improve non-section-aligned low memory mapping
In-Reply-To: <CAHkaATQPabp9WW0nZnPC373FDG7XdGKztPA2Xx7J1E12+USr8w@mail.gmail.com>
References: <CAHkaATQPabp9WW0nZnPC373FDG7XdGKztPA2Xx7J1E12+USr8w@mail.gmail.com>
Message-ID: <20150426081313.GI2258@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Min-Hua Chen

On Sun, Apr 26, 2015 at 03:41:17PM +0800, Min-Hua Chen wrote:
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 2495c8c..6a618f9 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -138,7 +138,7 @@ void show_mem(unsigned int filter)
>  static void __init find_limits(unsigned long *min, unsigned long *max_low,
>         unsigned long *max_high)
>  {
> - *max_low = PFN_DOWN(memblock_get_current_limit());
> + *max_low = PFN_DOWN(arm_lowmem_limit);
>   *min = PFN_UP(memblock_start_of_DRAM());
>   *max_high = PFN_DOWN(memblock_end_of_DRAM());
>  }

Your patch is whitespace damaged, and can't be applied as is. Please consider 
using git send-email to send properly formatted patches. See the EXAMPLE 
section in http://git-scm.com/docs/git-send-email for example of git 
send-email using a gmail account.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 May 2015 08:33:05 +0300
Subject: [EDT][PATCH 1/1] hw_breakpoint.c :cpu hotplug handling
In-Reply-To: <556690501.99511431494646065.JavaMail.weblogic@ep2mlwas05a>
References: <556690501.99511431494646065.JavaMail.weblogic@ep2mlwas05a>
Message-ID: <20150513053305.GK2558@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maninder Singh,

On Wed, May 13, 2015 at 05:24:07AM +0000, Maninder Singh wrote:
> EP-2DAD0AFA905A4ACB804C4F82A001242F
> 
> Subject: [PATCH 1/1] hw_breakpoint.c :cpu hotplug handling
> 
> This patch adds support for CPU hotplug, It re-installl all installed watchpoints and breakpoints
> back on H/W in case of cpu-hot plug.
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Amit Arora <amit.arora@samsung.com>
> Reviewed-by: Ajeet Yadav <ajeet.y@samsung.com>
> ---
>  arch/arm/kernel/hw_breakpoint.c |   56 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index dc7d0a9..172bfa8 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -388,6 +388,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return 0;
>  }
>  
> +/*
> + * reInstall a perf counter breakpoint.
> + */
> +void arch_reinstall_hw_breakpoint(int index, int type)

Static?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

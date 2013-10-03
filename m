From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 11:36:15 +0900
Subject: [PATCH 01/10] ARM: shmobile: Introduce
 r8a7791_add_standard_devices()
In-Reply-To: <20131001081153.4136.72073.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081153.4136.72073.sendpatchset@w520>
Message-ID: <20131003023614.GA28463@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:11:53PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Introduce the function r8a7791_add_standard_devices() that
> follows the same style as other mach-shmobile SoC code and
> allows C version of board code to add on-chip devices.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the soc3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.

> ---
> 
>  arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 +
>  arch/arm/mach-shmobile/setup-r8a7791.c        |    5 +++++
>  2 files changed, 6 insertions(+)
> 
> --- 0001/arch/arm/mach-shmobile/include/mach/r8a7791.h
> +++ work/arch/arm/mach-shmobile/include/mach/r8a7791.h	2013-10-01 16:23:46.000000000 +0900
> @@ -1,6 +1,7 @@
>  #ifndef __ASM_R8A7791_H__
>  #define __ASM_R8A7791_H__
>  
> +void r8a7791_add_standard_devices(void);
>  void r8a7791_add_dt_devices(void);
>  void r8a7791_clock_init(void);
>  void r8a7791_init_early(void);
> --- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2013-10-01 16:24:35.000000000 +0900
> @@ -129,6 +129,11 @@ void __init r8a7791_add_dt_devices(void)
>  	r8a7791_register_cmt(00);
>  }
>  
> +void __init r8a7791_add_standard_devices(void)
> +{
> +	r8a7791_add_dt_devices();
> +}
> +
>  void __init r8a7791_init_early(void)
>  {
>  #ifndef CONFIG_ARM_ARCH_TIMER
> 

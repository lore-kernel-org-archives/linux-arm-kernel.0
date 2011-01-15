From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 15 Jan 2011 20:05:49 +0530
Subject: ARM: CPU hotplug: fix hard-coded control register constants
In-Reply-To: <20110114120838.GC15996@n2100.arm.linux.org.uk>
References: <4D303758.4060608@st.com> <4D30386B.7020200@st.com>
	<20110114120437.GB15996@n2100.arm.linux.org.uk>
	<20110114120838.GC15996@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinjHxxhKGoPhg26eoWy71LP2iaPFvu4aoLcS=dX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/14/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> Subject: [PATCH] ARM: fix wrongly patched constants
>
> e3d9c625 (ARM: CPU hotplug: fix hard-coded control register constants)
> changed the wrong constants in the hotplug assembly code.  Fix this.
>
> Reported-by: viresh kumar <viresh.kumar@st.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-s5pv310/hotplug.c |    4 ++--
>  arch/arm/mach-tegra/hotplug.c   |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv310/hotplug.c
> b/arch/arm/mach-s5pv310/hotplug.c
> index afa5392..c24235c 100644
> --- a/arch/arm/mach-s5pv310/hotplug.c
> +++ b/arch/arm/mach-s5pv310/hotplug.c
> @@ -30,10 +30,10 @@ static inline void cpu_enter_lowpower(void)
>  	 * Turn off coherency
>  	 */
>  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %2\n"
> +	"	bic	%0, %0, #0x20\n"
>  	"	mcr	p15, 0, %0, c1, c0, 1\n"
>  	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, #0x04\n"
> +	"	bic	%0, %0, %2\n"
>  	"	mcr	p15, 0, %0, c1, c0, 0\n"
>  	  : "=&r" (v)
>  	  : "r" (0), "Ir" (CR_C)
> diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
> index a5cb1ce..f329404 100644
> --- a/arch/arm/mach-tegra/hotplug.c
> +++ b/arch/arm/mach-tegra/hotplug.c
> @@ -26,10 +26,10 @@ static inline void cpu_enter_lowpower(void)
>  	 * Turn off coherency
>  	 */
>  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %2\n"
> +	"	bic	%0, %0, #0x20\n"
>  	"	mcr	p15, 0, %0, c1, c0, 1\n"
>  	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, #0x04\n"
> +	"	bic	%0, %0, %2\n"
>  	"	mcr	p15, 0, %0, c1, c0, 0\n"
>  	  : "=&r" (v)
>  	  : "r" (0), "Ir" (CR_C)

Acked-by: Viresh Kumar <viresh.kumar@st.com>

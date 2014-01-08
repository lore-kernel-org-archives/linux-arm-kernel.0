From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Jan 2014 18:00:14 -0200
Subject: [PATCH v3] ARM: imx: add select on ARCH_MXC for cpufreq support
In-Reply-To: <1389210991-23688-1-git-send-email-john.tobias.ph@gmail.com>
References: <1389210991-23688-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <CAOMZO5CxKrc4_q6xRpkxxD3i5RRkTqm=zTy3txujyjf8-qVNkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Wed, Jan 8, 2014 at 5:56 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Moved ARCH_HAS_CPUFREQ, HAVE_IMX_ANATOP and PM_OPP on ARCH_MXC so that
> the user can enable the cpufreq support for iMX6Q and/or iMX6SL.
>
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  arch/arm/mach-imx/Kconfig | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 7a6e6f7..3c326be 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -1,5 +1,6 @@
>  config ARCH_MXC
>         bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
> +       select ARCH_HAS_CPUFREQ
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_CPU_SUSPEND if PM
>         select ARM_PATCH_PHYS_VIRT
> @@ -9,8 +10,10 @@ config ARCH_MXC
>         select GENERIC_ALLOCATOR
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_IRQ_CHIP
> +       select HAVE_IMX_ANATOP

This option is for mx6 only, so better not put it inside ARCH_MXC.

Regards,

Fabio Estevam

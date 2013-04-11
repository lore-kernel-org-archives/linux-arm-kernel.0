From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 11 Apr 2013 19:08:35 -0300
Subject: [PATCH] ARM: imx: Select IRAM_ALLOC
In-Reply-To: <1365717837-20488-1-git-send-email-festevam@gmail.com>
References: <1365717837-20488-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5DR8VY1DkcMBH1oJucYpjhV44QT55LGEO9=KEC=_S5CvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 7:03 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Since commit 391630c5bf11 (media: coda: use genalloc API) the following build
> error happens with imx_v4_v5_defconfig:
>
> drivers/built-in.o: In function 'coda_remove':
> clk-composite.c:(.text+0x112180): undefined reference to 'gen_pool_free'
> drivers/built-in.o: In function 'coda_probe':
> clk-composite.c:(.text+0x112310): undefined reference to 'of_get_named_gen_pool'
> clk-composite.c:(.text+0x1123f4): undefined reference to 'gen_pool_alloc'
> clk-composite.c:(.text+0x11240c): undefined reference to 'gen_pool_virt_to_phys'
> clk-composite.c:(.text+0x112458): undefined reference to 'dev_get_gen_pool'
>
> Select IRAM_ALLOC on all SoCs that are possible users of the coda driver.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 78f795d..a025cf8 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -124,6 +124,7 @@ config SOC_IMX27
>         select COMMON_CLK
>         select CPU_ARM926T
>         select IMX_HAVE_IOMUX_V1
> +       select IRAM_ALLOC

Actually I think we can remove IRAM_ALLOC completely now in favor of
GENERIC_ALLOCATOR.

Will send a new version of the patch.

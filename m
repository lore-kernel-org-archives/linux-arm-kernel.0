From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Oct 2010 15:04:46 +0200
Subject: [PATCH 1/2] ARM: S5PV310: Add support SROMC
In-Reply-To: <1286972144-763-2-git-send-email-sbkim73@samsung.com>
References: <1286972144-763-1-git-send-email-sbkim73@samsung.com>
	<1286972144-763-2-git-send-email-sbkim73@samsung.com>
Message-ID: <00e301cb6ad7$3842b5c0$a8c82140$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, October 13, 2010 2:16 PM Sangbeom Kim wrote:

> From: Daein Moon <moon9124@samsung.com>
> 
> This patch adds support SROMC for S5PV310 and S5PC210.
> 
> Signed-off-by: Daein Moon <moon9124@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  arch/arm/mach-s5pv310/cpu.c                    |    5 ++
>  arch/arm/mach-s5pv310/include/mach/map.h       |    4 ++
>  arch/arm/mach-s5pv310/include/mach/regs-srom.h |   50 ++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-srom.h
> 
> diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
> index ffed262..873783a 100644
> --- a/arch/arm/mach-s5pv310/cpu.c
> +++ b/arch/arm/mach-s5pv310/cpu.c
> @@ -81,6 +81,11 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
>  		.pfn		= __phys_to_pfn(S3C_PA_UART),
>  		.length		= SZ_512K,
>  		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_SROMC,
> +		.pfn		= __phys_to_pfn(S5PV310_PA_SROMC),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
>  	},
>  };

Do You really need to make a permanent mapping for the SROMC area? Cannot the
setup code in the mach-smdk*.c call ioremap(S5PV310_PA_SROMC) and put the address it
got to the ethernet device? This area will be probably useless for boards other than
SMDK.

<snip>

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

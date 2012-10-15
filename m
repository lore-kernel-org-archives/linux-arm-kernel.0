From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 15 Oct 2012 23:18:23 +0900
Subject: [PATCH] ARM: dts: exynos4210-trats: Split memory into 4 sections
In-Reply-To: <1349779199-30665-1-git-send-email-t.figa@samsung.com>
References: <1349779199-30665-1-git-send-email-t.figa@samsung.com>
Message-ID: <10e301cdaadf$ef547150$cdfd53f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Since the maximum section size on mach-exynos is set to 256MiB, boards
> with memory configuration defined using sections bigger than 256MiB will
> fail to boot with a kernel panic.
> 
I don't think so and it works fine in my side. Probably, the reason of
kernel panic you said is not a maximum sections size?

> This patch modifies the dts file of Samsung Trats board to define four
> sections of 256MiB instead of two of 512MiB to fix the boot problem.
> 
BTW, if this patch can fix the problem, OK, I will apply this for now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-trats.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts
> b/arch/arm/boot/dts/exynos4210-trats.dts
> index 73567b8..a21511c 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -20,8 +20,10 @@
>  	compatible = "samsung,trats", "samsung,exynos4210";
> 
>  	memory {
> -		reg =  <0x40000000 0x20000000
> -			0x60000000 0x20000000>;
> +		reg =  <0x40000000 0x10000000
> +			0x50000000 0x10000000
> +			0x60000000 0x10000000
> +			0x70000000 0x10000000>;
>  	};
> 
>  	chosen {
> --
> 1.7.12

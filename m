From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 14:13:04 +0200
Subject: [PATCH] ARM: EXYNOS: fix PL330 MDMA1 address in DT for Universal
 C210 board
In-Reply-To: <8667689.9TcYbn9cHO@amdc1032>
References: <8667689.9TcYbn9cHO@amdc1032>
Message-ID: <1448881.nvIAFtzzXr@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bart,

On Tuesday 20 of August 2013 13:22:45 Bartlomiej Zolnierkiewicz wrote:
> Revision 0 of Exynos4210 SoC (used on Universal C210 board) requires
> 'secure' PL330 MDMA1 address (0x12840000) instead of 'non-secure' one
> (0x12850000). Fix it by overriding the default PL330 MDMA1 address in
> exynos4210-universal_c210.dts.
> 
> This is a Device Tree (DT) version of commit 91280e7 ("ARM: EXYNOS:
> PL330 MDMA1 fix for revision 0 of Exynos4210 SOC") and fixes recent
> regression caused by conversion to DT-only setup on ARM EXYNOS.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-universal_c210.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> b/arch/arm/boot/dts/exynos4210-universal_c210.dts index 889cdad..d2e3f5f
> 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -350,3 +350,7 @@
>  		status = "okay";
>  	};
>  };
> +
> +&mdma1 {
> +	reg = <0x12840000 0x1000>;
> +};

Acked-by: Tomasz Figa <t.figa@samsung.com>

As a side note for other reviewers, Universal C210 is the only board based 
on Exynos4210 rev0, so board-level dts is the right place for such 
override.

Best regards,
Tomasz

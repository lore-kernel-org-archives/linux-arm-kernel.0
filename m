From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Apr 2017 10:23:07 +0200
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
In-Reply-To: <20170412083404.76cda3b3@canb.auug.org.au> (Stephen Rothwell's
 message of "Wed, 12 Apr 2017 08:34:04 +1000")
References: <20170412083404.76cda3b3@canb.auug.org.au>
Message-ID: <87a87mhw5w.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,
 
 On mer., avril 12 2017, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>
> Today's linux-next merge of the mvebu tree got a conflict in:
>
>   arch/arm64/configs/defconfig
>
> between commit:
>
>   3c9d36192802 ("arm64: set CONFIG_MMC_BCM2835=y in defconfig")
>
> from the arm-soc tree and commit:
>
>   6ff829553345 ("arm64: configs: enable SDHCI driver for Xenon")
>
> from the mvebu tree.

How do you want to proceed with this conflict?

Do you want that I merged arm-soc/next/arm64 in my mvebu/defconfig64
branch before applying my patch ?

Or do you prefer that I continue to base my branch on v4.11-rc1 and then
you will take care of the conflict when pulling the branch?

Thanks,

Gregory

>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> BTW, that arm-soc commit has no Signed-off-by from its committer :-(
>
> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc arch/arm64/configs/defconfig
> index ab4461b6b226,93b0aab959c0..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -402,7 -401,7 +402,8 @@@ CONFIG_MMC_DW_EXYNOS=
>   CONFIG_MMC_DW_K3=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SUNXI=y
>  +CONFIG_MMC_BCM2835=y
> + CONFIG_MMC_SDHCI_XENON=y
>   CONFIG_NEW_LEDS=y
>   CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_GPIO=y

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

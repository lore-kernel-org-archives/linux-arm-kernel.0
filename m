From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 16:47:49 -0800
Subject: [PATCH v4 12/12] arm64: defconfig: enable Armada 3700 related
 config
In-Reply-To: <1455646502-23834-13-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
 <1455646502-23834-13-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160225004749.GF10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 07:15:02PM +0100, Gregory CLEMENT wrote:
> This patch enables the configuration for the Armada 3700 family and for
> the related driver it uses.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/configs/defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 18ca9fb9e65f..7ca2f0247ec5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -31,6 +31,7 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_IOSCHED_DEADLINE is not set
> +CONFIG_ARCH_MVEBU=y
>  CONFIG_ARCH_BCM_IPROC=y
>  CONFIG_ARCH_BERLIN=y
>  CONFIG_ARCH_EXYNOS7=y

How did this end up here? It's in alphabetical order in the Kconfig, and here
you're inserting it first. Savedefconfig inserts it at the expected location.


I've fixed it up in the merge now, which isn't ideal. Maybe you edited
the defconfig by hand?


-Olof

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 07 Jul 2014 17:54:21 +0400
Subject: [PATCH] ARM: shmobile: Enable R-Car Gen 2 PCIe in
 shmobile_defconfig
In-Reply-To: <1404739432-1408-1-git-send-email-horms+renesas@verge.net.au>
References: <1404739432-1408-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <53BAA68D.609@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/07/2014 05:23 PM, Simon Horman wrote:

> The R-Car Gen 2 PCIe driver provides PCIe host support for
> Renesas R-Car Gen2 platforms. To increase hardware support enable
> the driver in the shmobile_defconfig multiplatform configuration.

> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/configs/shmobile_defconfig | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 5f05e98..6bc85a5 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -24,6 +24,7 @@ CONFIG_PL310_ERRATA_588369=y
>   CONFIG_ARM_ERRATA_754322=y
>   CONFIG_PCI=y
>   CONFIG_PCI_RCAR_GEN2=y
> +CONFIG_PCI_RCAR_GEN2_PCIE=y

    Hmm, I'm not sure why the option has GEN2 -- the driver claims support for 
R8A7779 as well as R8A779x. Probably the option should be renamed.

WBR, Sergei

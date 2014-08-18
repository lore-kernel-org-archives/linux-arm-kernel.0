From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 18 Aug 2014 16:19:56 +0200
Subject: [PATCH 1/5] mmc: remove .owner field for drivers using
 module_platform_driver
In-Reply-To: <1407860069-12706-2-git-send-email-peter.griffin@linaro.org>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
 <1407860069-12706-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <3815db00-4b32-4484-b97e-2144dc5abb45@BY2FFO11FD040.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 08/12/2014 06:14 PM, Peter Griffin wrote:
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/mmc/host/jz4740_mmc.c      | 1 -
>  drivers/mmc/host/moxart-mmc.c      | 1 -
>  drivers/mmc/host/mxcmmc.c          | 1 -
>  drivers/mmc/host/mxs-mmc.c         | 1 -
>  drivers/mmc/host/omap.c            | 1 -
>  drivers/mmc/host/omap_hsmmc.c      | 1 -
>  drivers/mmc/host/pxamci.c          | 1 -
>  drivers/mmc/host/rtsx_pci_sdmmc.c  | 1 -
>  drivers/mmc/host/rtsx_usb_sdmmc.c  | 1 -
>  drivers/mmc/host/s3cmci.c          | 1 -
>  drivers/mmc/host/sdhci-bcm-kona.c  | 1 -
>  drivers/mmc/host/sdhci-bcm2835.c   | 1 -
>  drivers/mmc/host/sdhci-cns3xxx.c   | 1 -
>  drivers/mmc/host/sdhci-dove.c      | 1 -
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 -
>  drivers/mmc/host/sdhci-msm.c       | 1 -
>  drivers/mmc/host/sdhci-of-arasan.c | 1 -
>  drivers/mmc/host/sdhci-of-esdhc.c  | 1 -
>  drivers/mmc/host/sdhci-of-hlwd.c   | 1 -
>  drivers/mmc/host/sdhci-pxav2.c     | 1 -
>  drivers/mmc/host/sdhci-pxav3.c     | 1 -
>  drivers/mmc/host/sdhci-s3c.c       | 1 -
>  drivers/mmc/host/sdhci-sirf.c      | 1 -
>  drivers/mmc/host/sdhci-spear.c     | 1 -
>  drivers/mmc/host/sdhci-tegra.c     | 1 -
>  drivers/mmc/host/sh_mmcif.c        | 1 -
>  drivers/mmc/host/sh_mobile_sdhi.c  | 1 -
>  drivers/mmc/host/sunxi-mmc.c       | 1 -
>  28 files changed, 28 deletions(-)

I have checked this for all xilinx drivers we have in the tree
and I have sent similar patches.
This problem is probably in all subsystems.
With communication with Mark Brown. Don't you have
cocinelle script for fixing this everywhere?

Thanks,
Michal



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/db358ef2/attachment.sig>

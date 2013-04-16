From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Apr 2013 12:13:00 +0300
Subject: [PATCH] ahci: sata: add support for exynos5440 sata
In-Reply-To: <1366103404-14105-1-git-send-email-ks.giri@samsung.com>
References: <1366103404-14105-1-git-send-email-ks.giri@samsung.com>
Message-ID: <20130416091300.GD25040@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 16, 2013 at 02:40:04PM +0530, Girish K S wrote:
> This patch adds the compatible string of the exynos5440 sata controller
> compliant with the ahci 1.3 and sata 3.0 specification.
> 
> Signed-off-by: Girish K S <ks.giri@samsung.com>
> ---
>  drivers/ata/ahci_platform.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 7a8a284..c06f021 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -327,6 +327,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
>  
>  static const struct of_device_id ahci_of_match[] = {
>  	{ .compatible = "snps,spear-ahci", },
> +	{ .compatible = "samsung,exynos5440-ahci", },

is this an IP designed by samsung or something you licensed from e.g
snps ? If the latter you should add:

"snps,ahci"

instead. Right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/ff530ab3/attachment.sig>

From: r65037@freescale.com (Zhu Richard-R65037)
Date: Tue, 18 Jun 2013 02:19:52 +0000
Subject: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
In-Reply-To: <20130618020153.GB28381@S2101-09.ap.freescale.net>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
 <1371462767-16630-3-git-send-email-r65037@freescale.com>,
 <20130618020153.GB28381@S2101-09.ap.freescale.net>
Message-ID: <0E83723C55F66F43A6041464FE31119D303700@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun&Shawn:
Thanks for your comments.

Hi Tejun:
I looked through the for-next branch of the libata git-repo, there maybe a merge conflict.
"
static const struct of_device_id ahci_of_match[] = { 
        { .compatible = "snps,spear-ahci", },
        { .compatible = "snps,exynos5440-ahci", },
        {}, 
};
MODULE_DEVICE_TABLE(of, ahci_of_match);
"

How about to re-change the patch, based on for-next branch of the libata git-repo.

Hi Shawn:
About the one similar IP, multiple platform specific strings inventions.
Waiting for DT's people?s opinion.


Best Regards
Richard Zhu
________________________________________
From: Shawn Guo [shawn.guo at linaro.org]
Sent: Tuesday, June 18, 2013 10:01 AM
To: Richard Zhu
Cc: linux-arm-kernel at lists.infradead.org; jgarzik at pobox.com; linux-ide at vger.kernel.org; Zhu Richard-R65037; devicetree-discuss at lists.ozlabs.org
Subject: Re: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata support

On Mon, Jun 17, 2013 at 05:52:46PM +0800, Richard Zhu wrote:
> imx6q contains the Synopsys AHCI SATA controller which shares
> ahci_platform driver with other controllers.
>
> This patch updates the DT compatible list for ahci_platform,
> and enable the imx6q ahci sata support.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  drivers/ata/ahci_platform.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 7a8a284..61f2142 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -327,6 +327,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
>
>  static const struct of_device_id ahci_of_match[] = {
>       { .compatible = "snps,spear-ahci", },
> +     { .compatible = "snps,imx-ahci", },

I'm not sure it makes much sense to invent multiple platform specific
strings for an IP which is completely compatible between them.
Why don't we just have a generic compatible string like "snps,ahci"
for all those compatible platforms, and only add platform specific
string when there is incompatibility on particular platform to deal
with?

Added devicetree-discuss to get DT people's opinion.

Shawn

>       {},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
> --
> 1.7.5.4
>

From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Jun 2013 10:32:38 +0800
Subject: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
In-Reply-To: <0E83723C55F66F43A6041464FE31119D303700@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
 <1371462767-16630-3-git-send-email-r65037@freescale.com>
 <20130618020153.GB28381@S2101-09.ap.freescale.net>
 <0E83723C55F66F43A6041464FE31119D303700@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20130618023236.GA28384@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 02:19:52AM +0000, Zhu Richard-R65037 wrote:
> Hi Tejun&Shawn:
> Thanks for your comments.
> 
> Hi Tejun:
> I looked through the for-next branch of the libata git-repo, there maybe a merge conflict.
> "
> static const struct of_device_id ahci_of_match[] = { 
>         { .compatible = "snps,spear-ahci", },
>         { .compatible = "snps,exynos5440-ahci", },

This is exactly what I'm concerned about.  We will end up with a huge
match table with all different platform specific compatible strings in
there.  But they're all matching to the same programming model of the
same IP block.  That's not how device tree compatible table works.

>         {}, 
> };
> MODULE_DEVICE_TABLE(of, ahci_of_match);
> "
> 
> How about to re-change the patch, based on for-next branch of the libata git-repo.
> 
Yes, I think the driver part and platform part can go separately.

Shawn

From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 20 May 2014 11:23:07 +0200
Subject: [PATCH v4 4/7] ata: ahci_platform: add the Marvell Berlin AHCI
 compatible
In-Reply-To: <537B1DD3.2040104@gmail.com>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-5-git-send-email-antoine.tenart@free-electrons.com>
 <537B1DD3.2040104@gmail.com>
Message-ID: <20140520092307.GA26491@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:18:11AM +0200, Sebastian Hesselbarth wrote:
> On 05/20/2014 11:04 AM, Antoine T?nart wrote:
> >The Marvell Berlin AHCI has all his specific in the PHY driver. It then
> >only need to use the libahci functions to work properly.
> 
> If it is that generic, ..
> 
> >Add its compatible into the libahci_platform driver.
> >
> >Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> >---
> >  drivers/ata/ahci_platform.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> >index ef67e79944f9..bc050aabf206 100644
> >--- a/drivers/ata/ahci_platform.c
> >+++ b/drivers/ata/ahci_platform.c
> >@@ -76,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
> >  	{ .compatible = "snps,exynos5440-ahci", },
> >  	{ .compatible = "ibm,476gtr-ahci", },
> >  	{ .compatible = "snps,dwc-ahci", },
> >+	{ .compatible = "marvell,berlin-ahci", },
> 
> .. why have a Marvell-specific compatible?

Well, the 3 other compatibles seemed as generic as the marvell one. Just
following what was done before here.

> How about "generic-ahci" instead, like we have for other fooHCIs
> already?

That would avoid an endless list of compatibles :)

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

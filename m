From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:33:02 +0100
Subject: [PATCH 2/8] s3c6410: sdhci: Adding additional data in sdhci
	platform data structure.
In-Reply-To: <06AE2DFB461F4BBD8937AC1512295974@sisodomain.com>
References: <4AABC6A7.6050707@gmail.com>
	<06AE2DFB461F4BBD8937AC1512295974@sisodomain.com>
Message-ID: <20090916003302.GO13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 06:59:45PM +0530, Thomas P. Abraham wrote:
> Hi Maurus,
> 
> The patch "[PATCH 6/8] s3c6410: sdhci: Modify platform data for sdhci-1" 
> was submitted to populate the hsmmc1 platform data.

Please do not split the changes up like this, the best thing to do is
that if a change in the setup is required for >1 device, then place
them in one go so that changes applied do not leave the kernel broken
in between commits.

> Thanks,
> Thomas.
> 
> 
> ----- Original Message ----- 
> From: "Maurus Cuelenaere" <mcuelenaere@gmail.com>
> To: <linux-arm-kernel@lists.infradead.org>; <thomas.ab@samsung.com>
> Sent: Saturday, September 12, 2009 9:34 PM
> Subject: Re: [PATCH 2/8] s3c6410: sdhci: Adding additional data in sdhci 
> platform data structure.
> 
> 
> >Hi,
> >
> >this breaks hsmmc1 (and hsmmc2).
> >
> >Attached patch fixes hsmmc1.
> >
> >Regards,
> >Maurus Cuelenaere
> >
> >From a743b9c3b7a6b63e2c0ccf22a45a06952920dff4 Mon Sep 17 00:00:00 2001
> >From: Maurus Cuelenaere <mcuelenaere@gmail.com>
> >Date: Sat, 12 Sep 2009 17:40:33 +0200
> >
> >This patch adds additional information about the parent clock
> >name, sdhci clock name and desired sdhci operating frequency
> >for hsmmc1 (based on e52782df345ec3e826701438ef42d2a8425bb973).
> >
> >Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> >---
> > arch/arm/plat-s3c/dev-hsmmc1.c |    3 +++
> > 1 files changed, 3 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/plat-s3c/dev-hsmmc1.c 
> >b/arch/arm/plat-s3c/dev-hsmmc1.c
> >index e49bc4c..d8c8f61 100644
> >--- a/arch/arm/plat-s3c/dev-hsmmc1.c
> >+++ b/arch/arm/plat-s3c/dev-hsmmc1.c
> >@@ -41,6 +41,9 @@ struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
> >     .max_width    = 4,
> >     .host_caps    = (MMC_CAP_4_BIT_DATA |
> >                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
> >+    .clk_parent_name    = "dout_mpll",
> >+    .clk_source_name     = "mmc_bus",
> >+    .clk_speed        = 50*MHZ,
> > };
> >
> > struct platform_device s3c_device_hsmmc1 = {
> >-- 
> >1.6.3.3
> >
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

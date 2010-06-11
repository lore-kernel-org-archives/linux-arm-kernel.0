From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 06:24:07 +0100
Subject: [PATCH 1/5] sdhci-s3c: depend on plat-samsung
In-Reply-To: <000701cb08fd$2f8e15a0$8eaa40e0$%kim@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
	<1276076383-24825-2-git-send-email-m.szyprowski@samsung.com>
	<000701cb08fd$2f8e15a0$8eaa40e0$%kim@samsung.com>
Message-ID: <20100611052407.GX7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 11, 2010 at 09:29:38AM +0900, Kukjin Kim wrote:
> Marek Szyprowski wrote:
> > 
> > Most Samsung SoC have support for SDHCI block, so make the driver
> > dependent on the Samsung platform instead on listing all SoCs in the
> > Kconfig (and updating it again when support for the new SoC variant is
> > added).
> > 
> Hi, Marek
> 
> Kyungmin Park already submitted same patch.

Hmm, Mr Park and Co really need to learn how to handle the treatment of
patches. I'm really disapointed that these patches get submitted without
the proper authour accreditation. If this isn't sorted out then I for
one will start thinking about giving this stuff an automatic reject.

Please ensure that the original authour of a patch is accredited for
the work, and the right sign-off and any other ack data is kept with
the patch. There's documentation about most of this in the kernel
already at Documentation/SubmittingPatches.
 
> And Andrew Morton added to the -mm tree.
> http://www.spinics.net/lists/mm-commits/msg79159.html
> 
> But, I think your comment is better...
> 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/mmc/host/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index e171e77..acf5bf6 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -123,7 +123,7 @@ config MMC_SDHCI_PLTFM
> > 
> >  config MMC_SDHCI_S3C
> >  	tristate "SDHCI support on Samsung S3C SoC"
> > -	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
> > +	depends on MMC_SDHCI && PLAT_SAMSUNG
> >  	help
> >  	  This selects the Secure Digital Host Controller Interface (SDHCI)
> >  	  often referrered to as the HSMMC block in some of the Samsung S3C
> > --
> 
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
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

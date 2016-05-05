From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 5 May 2016 09:41:32 +0000
Subject: [v10, 7/7] mmc: sdhci-of-esdhc: fix host version for
 T4240-R1.0-R2.0
In-Reply-To: <4448030.Zs8fVnr3nm@wuerfel>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1462417950-46796-8-git-send-email-yangbo.lu@nxp.com>
 <4448030.Zs8fVnr3nm@wuerfel>
Message-ID: <HE1PR04MB0889B52134A43C0E7A452B7BF87C0@HE1PR04MB0889.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, May 05, 2016 4:32 PM
> To: linuxppc-dev at lists.ozlabs.org
> Cc: Yangbo Lu; linux-mmc at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> linux-clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> foundation.org; netdev at vger.kernel.org; Mark Rutland;
> ulf.hansson at linaro.org; Russell King; Bhupesh Sharma; Joerg Roedel;
> Santosh Shilimkar; Yang-Leo Li; Scott Wood; Rob Herring; Claudiu Manoil;
> Kumar Gala; Xiaobo Xie; Qiang Zhao
> Subject: Re: [v10, 7/7] mmc: sdhci-of-esdhc: fix host version for T4240-
> R1.0-R2.0
> 
> On Thursday 05 May 2016 11:12:30 Yangbo Lu wrote:
> >
> > +       fsl_guts_init();
> > +       svr = fsl_guts_get_svr();
> > +       if (svr) {
> > +               esdhc->soc_ver = SVR_SOC_VER(svr);
> > +               esdhc->soc_rev = SVR_REV(svr);
> > +       } else {
> > +               dev_err(&pdev->dev, "Failed to get SVR value!\n");
> > +       }
> > +
> >
> 
> 
> Sorry for jumping in again after not participating in the discussion for
> the past few versions.
> 
> What happened to my suggestion of making this a platform-independent
> interface to avoid the link time dependency?
> 
> Specifically, why not add an exported function to drivers/base/soc.c that
> uses glob_match() for comparing a string in the device driver to the ID
> of the SoC that is set by whatever SoC identifying driver the platform
> has?
> 
> 	Arnd

[Lu Yangbo-B47093] I think this has been discussed in v6.
You can find Scott's comments about this in below link.
https://patchwork.kernel.org/patch/8544501/

Thanks.

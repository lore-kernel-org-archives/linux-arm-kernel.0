From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 May 2016 10:31:36 +0200
Subject: [v10,
 7/7] mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
In-Reply-To: <1462417950-46796-8-git-send-email-yangbo.lu@nxp.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1462417950-46796-8-git-send-email-yangbo.lu@nxp.com>
Message-ID: <4448030.Zs8fVnr3nm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 May 2016 11:12:30 Yangbo Lu wrote:
> 
> +       fsl_guts_init();
> +       svr = fsl_guts_get_svr();
> +       if (svr) {
> +               esdhc->soc_ver = SVR_SOC_VER(svr);
> +               esdhc->soc_rev = SVR_REV(svr);
> +       } else {
> +               dev_err(&pdev->dev, "Failed to get SVR value!\n");
> +       }
> +
> 


Sorry for jumping in again after not participating in the discussion for the
past few versions.

What happened to my suggestion of making this a platform-independent interface
to avoid the link time dependency?

Specifically, why not add an exported function to drivers/base/soc.c that
uses glob_match() for comparing a string in the device driver to the ID
of the SoC that is set by whatever SoC identifying driver the platform
has?

	Arnd

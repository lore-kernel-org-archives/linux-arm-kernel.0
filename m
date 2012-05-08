From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 May 2012 22:32:05 +0800
Subject: [PATCH 02/10] mmc: mxs-mmc: let ssp_is_old take host as parameter
In-Reply-To: <201205080143.49806.marex@denx.de>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-3-git-send-email-shawn.guo@linaro.org>
 <201205080143.49806.marex@denx.de>
Message-ID: <20120508143203.GD2199@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 01:43:49AM +0200, Marek Vasut wrote:
> >  #define SSP_VERSION_LATEST	4
> > -#define ssp_is_old()		(host->version < SSP_VERSION_LATEST)
> > +#define ssp_is_old(host)	(host->version < SSP_VERSION_LATEST)
> 
> (host)->version ... to make the macro safer.
> 
Sounds good.

> > -	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> > +	if ((sta & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> 
> ^ s/sta/stat/ ... did you try compiling this at all ? :-)
> 
This is an error introduced by a last minute rebase.  Thanks for
catching it.  Fixed.

-- 
Regards,
Shawn

From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Dec 2013 21:37:27 +0800
Subject: [PATCH V6 3/3] ahci: imx: Add i.MX53 support
In-Reply-To: <20131210114738.GA4097@pengutronix.de>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
 <1385369222-5288-3-git-send-email-marex@denx.de>
 <20131210114738.GA4097@pengutronix.de>
Message-ID: <20131210133723.GC26728@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 12:47:38PM +0100, Sascha Hauer wrote:
> > @@ -34,10 +34,21 @@ enum {
> >  	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
> >  };
> >  
> > +enum ahci_imx_type {
> > +	AHCI_IMX53,
> > +	AHCI_IMX6Q,
> > +};
> 
> Please next time introduce a SoC specific struct to encode the
> differences between SoCs. This way you can abstract away the differences
> in flags and function callbacks and don't end up with functions which
> do completely different things for different SoCs like currently in
> imx_sata_clock_enable(). The if (type == SOC_XY) style doesn't scale in
> many drivers anymore.

Yea, I was thinking about the same thing when reviewing the patch in the
first time, but decided to not comment on that because currently the
added functions are doing the similar/related thing.  But I agree that
SoC specific structure should be some thing more scalable and we should
go for in the future.

Shawn

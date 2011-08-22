From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 22 Aug 2011 20:21:33 +0200
Subject: [PATCH] ARM: mx27: Print silicon revision on boot
In-Reply-To: <20110822170911.GZ31404@pengutronix.de>
References: <1314028361-25622-1-git-send-email-fabio.estevam@freescale.com>
	<CAOMZO5BLpSKROCpo0N293VtqpE4RigwPnXmW6HHCt1skNHRZGg@mail.gmail.com>
	<20110822170911.GZ31404@pengutronix.de>
Message-ID: <201108222021.33243.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2011 07:09:11 PM Sascha Hauer wrote:
> On Mon, Aug 22, 2011 at 01:10:46PM -0300, Fabio Estevam wrote:
> > On Mon, Aug 22, 2011 at 1:05 PM, Marek Vasut <marek.vasut@gmail.com>
> > wrote: ...
> > 
> > > I didn't check really, but can't you just do some kind of a numeric
> > > transformation instead of storing strings ?
> > 
> > I am using the same approach used by other i.MX processors.
> 
> How about
> 
> imx_print_silicon_rev(const char *cpu, int srev)
> {
> 	if (srev == IMX_CHIP_REVISION_UNKNOWN)
> 		pr_info("CPU identified as %s, unknown revision\n");
> 	else
> 		pr_info("CPU identified as %s, silicon rev %d.%d\n",
> 			cpu, (srev >> 4) & 0xf, srev & 0xf);
> }
> 
> Sascha

Looks good

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 22 Aug 2011 19:09:11 +0200
Subject: [PATCH] ARM: mx27: Print silicon revision on boot
In-Reply-To: <CAOMZO5BLpSKROCpo0N293VtqpE4RigwPnXmW6HHCt1skNHRZGg@mail.gmail.com>
References: <1314028361-25622-1-git-send-email-fabio.estevam@freescale.com>
	<201108221805.58180.marek.vasut@gmail.com>
	<CAOMZO5BLpSKROCpo0N293VtqpE4RigwPnXmW6HHCt1skNHRZGg@mail.gmail.com>
Message-ID: <20110822170911.GZ31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 01:10:46PM -0300, Fabio Estevam wrote:
> On Mon, Aug 22, 2011 at 1:05 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> ...
> >
> > I didn't check really, but can't you just do some kind of a numeric
> > transformation instead of storing strings ?
> 
> I am using the same approach used by other i.MX processors.

How about

imx_print_silicon_rev(const char *cpu, int srev)
{
	if (srev == IMX_CHIP_REVISION_UNKNOWN)
		pr_info("CPU identified as %s, unknown revision\n");
	else
		pr_info("CPU identified as %s, silicon rev %d.%d\n",
			cpu, (srev >> 4) & 0xf, srev & 0xf);
}

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

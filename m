From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Jun 2012 11:21:57 +0200
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <CACRpkdbLMCirzyk-UbS0zx_TpY-mx51-aEn0bk-48eGMhmm=fg@mail.gmail.com>
References: <20120619012420.GJ19249@S2101-09.ap.freescale.net>
 <1569254394.2932189.1340107238237.JavaMail.root@advansee.com>
 <CACRpkdbLMCirzyk-UbS0zx_TpY-mx51-aEn0bk-48eGMhmm=fg@mail.gmail.com>
Message-ID: <20120620092157.GR28394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 10:35:21AM +0200, Linus Walleij wrote:
> On Tue, Jun 19, 2012 at 2:00 PM, Beno?t Th?baudeau
> <benoit.thebaudeau@advansee.com> wrote:
> 
> > Can you give me an example
> > that tells me by what you replaced those cpu_is_xxx()? By some feature test
> > macros?
> 
> Since this is a DT-enabled driver, add a boolean attribute for
> the DT node like "has-edge-select" and add that attribute to
> the SoC .dtsi files for the SoCs that has this feature.
> 
> Another (better) option is if there are magic numbers in the
> silicon register range that you can check for revision of that
> hardware in itself. Such auto-detect plug-n-play is always best.

If there would be such a register it would almost certainly be on different
register offsets on different SoCs...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

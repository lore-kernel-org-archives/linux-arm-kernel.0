From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 08:32:03 +0200
Subject: [PATCH 22/33] ARM: imx: add common clock support for pllv3
In-Reply-To: <20120427062120.GL2234@S2101-09.ap.freescale.net>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-23-git-send-email-s.hauer@pengutronix.de>
 <20120427062120.GL2234@S2101-09.ap.freescale.net>
Message-ID: <20120427063203.GN17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 02:21:22PM +0800, Shawn Guo wrote:
> On Wed, Apr 25, 2012 at 05:28:12PM +0200, Sascha Hauer wrote:
> > +static long clk_pllv3_round_rate(struct clk_hw *hw, unsigned long rate,
> > +				 unsigned long *prate)
> > +{
> > +	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
> 
> With patch 81536e0 (clk: always pass parent_rate into .round_rate) in
> there, *prate is just the parent_rate.  That said, we do not need to
> call __clk_get_rate and __clk_get_parent anywhere in this file.

The set_rate prototype has changed, round_rate not, so I missed this.
Will fix.

Thanks
 Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

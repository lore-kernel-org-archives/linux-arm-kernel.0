From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Jul 2011 08:29:32 +0200
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110726024354.GI21641@S2100-06.ap.freescale.net>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<20110726024354.GI21641@S2100-06.ap.freescale.net>
Message-ID: <20110726062931.GZ20587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 10:43:55AM +0800, Shawn Guo wrote:
> On Mon, Jul 25, 2011 at 02:46:30PM -0600, Grant Likely wrote:
> > On Mon, Jul 25, 2011 at 11:07:46PM +0800, Shawn Guo wrote:
> > > It adds function mxc_iomuxc_dt_init() to parse iomuxc pad configuration
> > 
> Specifying string in dts, and then parsing the string, mapping it to
> one of the huge MX53_PAD_ definition in kernel init code?
> 
> One thing I'm trying to do is to replace those huge iomux-mx*.h headers
> with dts binding, and then get rid of those headers from Linux tree.

I don't like these files either, so getting rid of them looks promising.
OTOH don't forget that we need some of the pins during runtime for
gpio/function switching.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

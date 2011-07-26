From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 27 Jul 2011 00:34:07 +0800
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110726062931.GZ20587@pengutronix.de>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<20110726024354.GI21641@S2100-06.ap.freescale.net>
	<20110726062931.GZ20587@pengutronix.de>
Message-ID: <20110726163406.GB19600@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 08:29:32AM +0200, Sascha Hauer wrote:
> On Tue, Jul 26, 2011 at 10:43:55AM +0800, Shawn Guo wrote:
> > On Mon, Jul 25, 2011 at 02:46:30PM -0600, Grant Likely wrote:
> > > On Mon, Jul 25, 2011 at 11:07:46PM +0800, Shawn Guo wrote:
> > > > It adds function mxc_iomuxc_dt_init() to parse iomuxc pad configuration
> > > 
> > Specifying string in dts, and then parsing the string, mapping it to
> > one of the huge MX53_PAD_ definition in kernel init code?
> > 
> > One thing I'm trying to do is to replace those huge iomux-mx*.h headers
> > with dts binding, and then get rid of those headers from Linux tree.
> 
> I don't like these files either, so getting rid of them looks promising.
> OTOH don't forget that we need some of the pins during runtime for
> gpio/function switching.
> 
Do we have plan to use Linus.W's pinmux subsystem, which will perfectly
work for runtime configuration?

-- 
Regards,
Shawn

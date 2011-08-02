From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 2 Aug 2011 12:43:40 +0100
Subject: [PATCH v3 1/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <20110802065814.GM31404@pengutronix.de>
References: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
	<1312226252-8566-2-git-send-email-shawn.guo@linaro.org>
	<20110802065814.GM31404@pengutronix.de>
Message-ID: <20110802114340.GA17952@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 08:58:14AM +0200, Sascha Hauer wrote:
> On Tue, Aug 02, 2011 at 03:17:31AM +0800, Shawn Guo wrote:
> > +
> > +	aips at 50000000 { /* AIPS1 */
> > +		spba at 50000000 {
> > +			esdhc at 50004000 { /* ESDHC1 */
> > +				cd-gpios = <&gpio0 1 0>; /* GPIO1_1 */
> > +				wp-gpios = <&gpio0 9 0>; /* GPIO1_9 */
> > +			};
> > +
> > +			esdhc at 50008000 { /* ESDHC2 */
> > +				status = "disabled";
> > +			};
> 
> I know the decision is that all devices are enabled by default and must
> be explicitely disabled like this. I really hope we can change this in
> the future for the following reasons:
> 
> - The imx53 device tree is not complete, several devices like nand, ipu
>   and rtc are missing. Now when imx53.dtsi gets the nand device, all
>   board devicetrees have to be changed to keep the old behaviour.
> - Most enabled device entries like the esdhc1 above have additional
>   nodes like cd-gpios anyway, so they must appear in the board tree
>   whereas the disabled devices just add additional churn.

I'll add this topic to the whiteboard for the kernel WG to discuss
this week.

http://pad.ubuntu.com/device-tree-workshop

g.

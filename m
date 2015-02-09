From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Feb 2015 11:27:21 +0000
Subject: [PATCH 09/13] ARM: dts: mediatek: Enable clock support for
 Mediatek MT8135.
In-Reply-To: <20150209112500.GU12209@pengutronix.de>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-10-git-send-email-s.hauer@pengutronix.de>
 <20150209105134.GF8656@n2100.arm.linux.org.uk>
 <20150209112500.GU12209@pengutronix.de>
Message-ID: <20150209112721.GG8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 12:25:00PM +0100, Sascha Hauer wrote:
> On Mon, Feb 09, 2015 at 10:51:34AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Feb 09, 2015 at 11:47:21AM +0100, Sascha Hauer wrote:
> > > From: James Liao <jamesjj.liao@mediatek.com>
> > > 
> > > This patch adds MT8135 clock controllers into device tree.
> > > @@ -86,6 +87,18 @@
> > >  			clock-frequency = <32000>;
> > >  			#clock-cells = <0>;
> > >  		};
> > > +
> > > +		clk_null: clk_null {
> > > +			compatible = "fixed-clock";
> > > +			#clock-cells = <0>;
> > > +			clock-frequency = <0>;
> > > +		};
> > > +
> > > +		clk26m: clk26m {
> > > +			compatible = "fixed-clock";
> > > +			#clock-cells = <0>;
> > > +			clock-frequency = <26000000>;
> > > +		};
> > 
> > Is this supposed to be here?
> 
> The clock support needs at least the clk26m clk. Do you think it should
> be in another patch or not present at all?

I didn't see anything which referenced either clk_null or clk26m in this
patch.  My main concern was that clk_null, but my concern grew when I
found that clk26m wasn't referenced either.

If the MT8135 needs it, shouldn't something in its description reference
this clock?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

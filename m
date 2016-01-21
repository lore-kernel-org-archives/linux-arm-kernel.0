From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jan 2016 09:29:10 +0000
Subject: [PATCH] ARM: dts: n900: Include adp1653 device
In-Reply-To: <20160121091241.GS7192@pali>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
Message-ID: <20160121092909.GH5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The merge window is open, which is when development code that was merged
in good time prior to the merge window is sent upstream to Linus.  Linux
maintainers may choose not to merge new code into their tree to avoid
disrupting the utility of linux-next until the merge window has closed.

linux-next is an integration tree to help find merge conflicts, it
exists to assist with the merge windows, not as a general test ground.
Thus, linux-next must only contain code for either the current open
merge window, or if the merge window is closed, the next merge window.

On Thu, Jan 21, 2016 at 10:12:41AM +0100, Pali Roh?r wrote:
> On Saturday 26 December 2015 00:40:12 Pali Roh?r wrote:
> > This patch adds adp1653 device into n900 DT structure. DT support in
> > adp1653 driver is there since v4.2-rc1 version.
> > 
> > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> > ---
> >  arch/arm/boot/dts/omap3-n900.dts |   15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> > index 5f5e0f3..ba93642 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -522,6 +522,21 @@
> >  		amstaos,cover-comp-gain = <16>;
> >  	};
> >  
> > +	adp1653: led-controller at 30 {
> > +		compatible = "adi,adp1653";
> > +		reg = <0x30>;
> > +		enable-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> > +
> > +		flash {
> > +			flash-timeout-us = <500000>;
> > +			flash-max-microamp = <320000>;
> > +			led-max-microamp = <50000>;
> > +		};
> > +		indicator {
> > +			led-max-microamp = <17500>;
> > +		};
> > +	};
> > +
> >  	lp5523: lp5523 at 32 {
> >  		compatible = "national,lp5523";
> >  		reg = <0x32>;
> 
> PING, who can take this patch?
> 
> I still do not see it in linus tree nor in others like arm-soc...
> 
> -- 
> Pali Roh?r
> pali.rohar at gmail.com

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

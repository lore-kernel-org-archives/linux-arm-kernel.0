From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 15:14:55 +0100
Subject: [PATCH 09/10] ARM: mvebu: add Device Tree files for Armada 39x
 SoC and board
In-Reply-To: <20150206172153.GY25985@lunn.ch>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1423238276-9206-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150206172153.GY25985@lunn.ch>
Message-ID: <20150220151455.461b97bb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 6 Feb 2015 18:21:53 +0100, Andrew Lunn wrote:

> > +	chosen {
> > +		bootargs = "console=ttyS0,115200 earlyprintk";
> > +	};
> > +
> 
> Arnd has been encouraging people not use earlyprintk here.  Also a
> stdout-path would be nice. We also seem to be missing aliases for the
> serial ports.

Right.


> > +		internal-regs {
> > +                        i2c at 11000 {
> > +				pinctrl-0 = <&i2c0_pins>;
> > +				pinctrl-names = "default";
> > +                                status = "okay";
> > +                                clock-frequency = <100000>;
> > +                        };
> > +
> > +			serial at 12000 {
> > +				pinctrl-0 = <&uart0_pins>;
> > +				pinctrl-names = "default";
> > +				status = "okay";
> > +			};
> > +
> 
> Tab vs space issue here somewhere? Probably the i2c node.

Yes, fixed.

> > +			pinctrl at 18000 {
> > +				uart0_pins: uart0-pins {
> > +					marvell,pins = "mpp0", "mpp1";
> > +					marvell,function = "ua0";
> > +				};
> > +
> > +				uart1_pins: uart1-pins {
> > +					marvell,pins = "mpp19", "mpp20";
> > +					marvell,function = "ua1";
> > +				};
> 
> Does it make sense to put there in the .dtsi file? I know there are
> other choices, but generally board manufacturers tend to follow the
> reference design.

I am not really convinced here: there are really many possible pin
muxing possibilities. Various pins for UART0 and UART1, whether you use
CTS/RTS or not, etc. I believe this is really the sort of pin mux
configuration that is best left at the board level.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 1 Jun 2015 18:48:59 +0200
Subject: [PATCH 16/16] ARM: at91/dt: Add Acme Arietta G25
In-Reply-To: <556C85E6.9060107@atmel.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432921649-21943-17-git-send-email-alexandre.belloni@free-electrons.com>
 <556C85E6.9060107@atmel.com>
Message-ID: <20150601164859.GM4710@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2015 at 18:18:46 +0200, Nicolas Ferre wrote :
> > + */
> > +/dts-v1/;
> > +#include "at91sam9g25.dtsi"
> > +/ {
> > +	model = "Acme Systems Arietta G25";
> > +	compatible = "acme,ariettag25", "atmel,at91sam9x5", "atmel,at91sam9";
> > +
> 
> Don't we need to add a "alias" group here, to be sure that the
> "stdout-path" is always good whatever appends to the underlying
> at91sam9g25.dtsi (nitpicking, I know ;-)) ?
> 

I've just checked and dtc seems to be doing the right thing, I'll do
that.

> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	memory {
> > +		reg = <0x20000000 0x8000000>;
> > +	};
> > +
> > +	clocks {
> > +		slow_xtal {
> > +			clock-frequency = <32768>;
> > +		};
> > +
> > +		main_xtal {
> > +			clock-frequency = <12000000>;
> > +		};
> > +	};
> > +
> > +	ahb {
> > +		apb {
> > +			mmc0: mmc at f0008000 {
> > +				pinctrl-0 = <
> > +				  &pinctrl_mmc0_slot0_clk_cmd_dat0
> > +				  &pinctrl_mmc0_slot0_dat1_3>;
> > +				status = "okay";
> > +
> > +				slot at 0 {
> > +					reg = <0>;
> > +					bus-width = <4>;
> > +				};
> > +			};
> > +
> > +			usb2: gadget at f803c000 {
> > +				status = "okay";
> > +			};
> > +
> > +			dbgu: serial at fffff200 {
> > +				status = "okay";
> > +			};
> > +
> > +			rtc at fffffeb0 {
> > +				status = "okay";
> > +			};
> > +		};
> > +
> > +		usb0: ohci at 00600000 {
> > +			status = "okay";
> > +			num-ports = <3>;
> > +		};
> > +
> > +		usb1: ehci at 00700000 {
> > +			status = "okay";
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		arietta_led {
> > +			label = "arietta_led";
> > +			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>; /* PB8 */
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +	};
> > +};
> > 
> 
> 
> -- 
> Nicolas Ferre

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

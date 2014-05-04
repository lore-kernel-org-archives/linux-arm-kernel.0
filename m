From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 5 May 2014 00:56:43 +0200
Subject: [PATCH v2 2/5] ARM: Kirkwood: Add DT descriptions for net2big
 and net5big.
In-Reply-To: <5366AF61.2090806@gmail.com>
References: <1399142114-24257-1-git-send-email-andrew@lunn.ch>
 <1399142114-24257-3-git-send-email-andrew@lunn.ch>
 <5366AF61.2090806@gmail.com>
Message-ID: <20140504225643.GC25314@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	chosen {
> > +		bootargs = "console=ttyS0,115200n8";
> 
> nit: add stdout-path = &uart0;

O.K. I had v1 of this patch before your cleanup, and forgot about
this.
 
> > +	};
> > +
> > +	ocp at f1000000 {
> > +		serial at 12000 {
> > +			status = "ok";
> 
> nit: s/ok/okay/

I copied a bad example .dts files :-(
 
> > +		};
> > +
> > +		spi at 10600 {
> > +			pinctrl-0 = <&pmx_spi>;
> > +			pinctrl-names = "default";
> > +			status = "okay";
> > +
> > +			flash at 0 {
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				compatible = "mxicy,mx25l4005a";
> > +				reg = <0>;
> > +				spi-max-frequency = <20000000>;
> > +				mode = <0>;
> > +
> > +				partition at 0 {
> > +					reg = <0x0 0x80000>;
> > +					label = "u-boot";
> > +				};
> > +			};
> > +		};
> > +
> > +		sata at 80000 {
> > +			status = "okay";
> > +			nr-ports = <2>;
> > +		};
> > +
> > +	};
> > +
> > +	gpio_keys {
> 
> nit: s/gpio_keys/gpio-keys/
> 

I think this one is debatable. The documentation is called
gpio_keys.txt, and the example uses gpio_keys. I don't mind chaging it
in this file, but maybe you can submit a patch changing the example in
the documentation?

> > +	gpio_poweroff {
> 
> nit: s/gpio_poweroff/gpio-poweroff/

ACK.
 
> If there is nothing more severe with this, I am sure Jason can
> just squash in the nits.

This still needs to be tested on hardware, so there is a good chance
of a respin.

   Andrew
 

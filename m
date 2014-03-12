From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 12:48:35 +0000
Subject: [PATCH v2 1/3] ata: ahci_st: Provide DT bindings for ST's SATA
 implementation
In-Reply-To: <20140312114257.GA17461@e106331-lin.cambridge.arm.com>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
 <20140312114257.GA17461@e106331-lin.cambridge.arm.com>
Message-ID: <20140312124835.GA22450@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +This binding describes a SATA device.
> > +
> > +Required properties:
> > + - compatible	   : Must be "st,ahci"
> 
> Is there not a more specific name? This is awfully generic.

There isn't one. ST only have one AHCI driver. The driver is named as
generically.

> > + - reg		   : Physical base addresses and length of register sets
> > + - interrupts	   : Interrupt associated with the SATA device
> > + - interrupt-names :   Associated name must be; "hostc"
> > + - resets	   : The power-down and soft-reset lines of SATA IP
> > + - reset-names	   :   Associated names must be; "pwr-dwn" and "sw-rst"
> 
> Get rid of the semicolon, it makes this harder to read. Same for the
> other -names proeprties.

Sure.

> > + - clocks	   : The phandle for the clock
> > + - clock-names	   :   Associated name must be; "ahci_clk"
> > + - phys		   : The phandle for the PHY device
> > + - phy-names	   :   Associated name must be; "ahci_phy"
> 
> This looks sane, but I'd like to see a more specific description and
> compatible string.

Specific description in what sense?

"This binding describes a SATA device."

to

"This binding describes ST's SATA device." ?

> > +Example:
> > +
> > +	sata0: sata at fe380000 {
> > +		compatible      = "st,ahci";
> > +		reg             = <0xfe380000 0x1000>;
> > +		interrupts      = <GIC_SPI 157 IRQ_TYPE_NONE>;
> > +		interrupt-names = "hostc";
> > +		phys	        = <&miphy365x_phy MIPHY_PORT_0 MIPHY_TYPE_SATA>;
> > +		phy-names       = "ahci_phy";
> > +		resets	        = <&powerdown STIH416_SATA0_POWERDOWN>,
> > +				  <&softreset STIH416_SATA0_SOFTRESET>;
> > +		reset-names     = "pwr-dwn", "sw-rst";
> > +		clocks	        = <&CLK_S_ICN_REG_0>;
> > +		clock-names     = "ahci_clk";
> > +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

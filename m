From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Nov 2013 17:38:59 -0800
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
In-Reply-To: <1379277856-24571-4-git-send-email-sre@debian.org>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
Message-ID: <20131121013858.GK10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@debian.org> [130915 13:56]:
> +
> +Example for Nokia N900:
> +
> +ssi-controller at 48058000 {
> +	compatible = "ti,omap3-ssi";
> +	ti,hwmods = "ssi";
> +
> +	reg = <0x48058000 0x1000>,
> +	      <0x48059000 0x1000>;
> +	reg-names = "sys",
> +		    "gdd";
> +
> +	interrupts = <55>;
> +	interrupt-names = "gdd_mpu";
> +
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;
> +
> +	ssi-port at 0 {
> +		compatible = "ti,omap3-ssi-port";
> +
> +		reg = <0x4805a000 0x800>,
> +		      <0x4805a800 0x800>;
> +		reg-names = "tx",
> +			    "rx";
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <51>,
> +			     <52>;
> +		interrupt-names = "mpu_irq0",
> +				  "mpu_irq1";
> +
> +		ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
> +	}
> +}

These should be in the omap3.dtsi file and not nested but separate. I'm almost
certain that these are completely independent hardware modules and this
means they can live their own PM life independently.

So can you please do a minimal patch for omap3.dtsi that just sets up
the standard resources separately for both modules the same way we have
for other hardware modules in omap3.dtsi do?

One of them should be called ssi, no idea what the other module name should
be as those register ranges show up as reserved in the docs I have.

The other binding pieces can be added later on as they get are ready.

Regards,

Tony

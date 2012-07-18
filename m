From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Jul 2012 09:16:17 +0200
Subject: [RFC PATCHv3 2/2] ARM: socfpga: Add DTS bindings for Altera's
 SOCFPGA
In-Reply-To: <1342572656-5205-3-git-send-email-dinguyen@altera.com>
References: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
 <1342572656-5205-3-git-send-email-dinguyen@altera.com>
Message-ID: <20120718091617.572070c2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 17 Jul 2012 18:50:56 -0600,
<dinguyen@altera.com> a ?crit :

> +	soc {
> +		amba {
> +			compatible = "arm,amba-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			pdma: pdma at ffe01000 {
> +				compatible = "arm,pl330", "arm,primecell";
> +				reg = <0xffe01000 0x1000>;
> +				interrupts = <0 180 4>;
> +			};
> +		};
> +
> +		apb_periphs {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			gmac0: stmmac at ff700000 {
> +				compatible = "st,spear600-gmac";
> +				reg = <0xff700000 0x2000>;
> +				interrupts = <0 115 4>;
> +				interrupt-names = "macirq";
> +				mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
> +				phy-mode = "gmii";
> +			};
> +		};

Are the pdma and gmac0 really specific to the cyclone board? Aren't
they similar to the uarts and timers in that they are part of the SoC
itself?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

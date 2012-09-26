From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 26 Sep 2012 12:44:05 +0200
Subject: [PATCH v3] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <1348652369-16649-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1348652369-16649-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120926104405.GM1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Some points:

- Can we have a more complete devicetree? For the i.MX27 I posted a
  devicetree containing the nodes I need, I wouldn't do that again.
  During creating the i.MX25   devicetree I realized that it's actually
  not much work to make it (nearly) complete. It'll save us from patching
  this file frequently. I am missing nodes at least for the GPT and CCM.
  These are currently not used, but I think we'll need them soon.
- Can we have devicetree clock lookups like Shawn has done for the i.MX6
  (and me for the i.MX25)?

On Wed, Sep 26, 2012 at 11:39:29AM +0200, Uwe Kleine-K?nig wrote:
> +			gpio3: gpio at 0x53fa4000 {
> +				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
> +				reg = <0x53fa4000 0x4000>;
> +				interrupts = <56>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			esdhc1: esdhc at 53fb4000 {
> +				compatible = "fsl,mx35-sdhc";
> +				reg = <0x53fb4000 0x4000>;
> +				interrupts = <7>;
> +				status = "disabled";
> +			};

Please add a bus-width = <4> property to the esdhc units. It's the default
right now, but this property might become mandatory.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 16 Jul 2012 14:20:19 +0200
Subject: [PATCHv3] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <1342430205-13702-2-git-send-email-andrew@lunn.ch>
References: <1342430205-13702-1-git-send-email-andrew@lunn.ch>
 <1342430205-13702-2-git-send-email-andrew@lunn.ch>
Message-ID: <20120716142019.3f6cdc26@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon, 16 Jul 2012 11:16:45 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> + - reg             : Offset and length of the register set for the device
> + - compatible      : Should be "marvell,mv64xxx-i2c"
> + - interrupts      : Te interrupt number

                        The

> +		i2c at 11000 {
> +			compatible = "marvell,mv64xxx-i2c";
> +			reg = <0x11000 0x20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <29>;
> +			clock-frequency = <400000>;
> +			timeout-ms = <1000>;
> +			status = "disable";

This should be "disabled". Any other status than "okay" is considered
as disabled, if I'm correct, but the right opposite to "okay" is
"disabled", as far as I'm aware.

The #ifdef machinery in the ->probe() function looks a bit ugly, but I
guess this can be cleaned up once all platforms using this driver will
have been converted to DT + clock framework.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

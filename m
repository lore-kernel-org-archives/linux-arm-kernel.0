From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 May 2014 07:39:32 -0700
Subject: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
References: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20140520143932.GA27830@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140520 07:26]:
> @@ -77,6 +94,15 @@
>  			0x30 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48: amdix enabled */
>  		>;
>  	};
> +
> +	dss_hdmi_pins: pinmux_dss_hdmi_pins {
> +		pinctrl-single,pins = <
> +			0x58 (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_hpd.hdmi_hpd */
> +			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
> +			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_scl */
> +			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sda */
> +		>;
> +	};
>  };
>  
>  &i2c2 {

This seems to apply with fuzz against omap-for-v3.16/dt-v2, but
should be updated against omap-for-v3.16/dt-v2 to use OMAP4_IOPAD
as omap4-duovero-parlor.dts is now using it. That makes checking
the muxing easier against the TRM. See commit 5efa994b0d49 for
the script Joachim used.

Regards,

Tony

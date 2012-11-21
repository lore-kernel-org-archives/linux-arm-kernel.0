From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Nov 2012 09:58:27 +0100
Subject: [PATCH 2/2] ARM: dts: mxs: add oled support for the cfa-10036
In-Reply-To: <1351674774-2891-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1351674774-2891-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351674774-2891-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50AC97B3.5070709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Shawn,

Le 31/10/2012 10:12, Maxime Ripard a ?crit :
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com> Cc:
> Brian Lilly <brian@crystalfontz.com> --- 
> arch/arm/boot/dts/imx28-cfa10036.dts |   19 +++++++++++++++++++ 1
> file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts
> b/arch/arm/boot/dts/imx28-cfa10036.dts index c03a577..816cae9
> 100644 --- a/arch/arm/boot/dts/imx28-cfa10036.dts +++
> b/arch/arm/boot/dts/imx28-cfa10036.dts @@ -33,11 +33,30 @@ };
> 
> apbx at 80040000 { +			pwm: pwm at 80064000 { +				pinctrl-names =
> "default"; +				pinctrl-0 = <&pwm4_pins_a>; +				status = "okay"; +
> }; + duart: serial at 80074000 { pinctrl-names = "default"; pinctrl-0
> = <&duart_pins_b>; status = "okay"; }; + +			i2c0: i2c at 80058000 { +
> pinctrl-names = "default"; +				pinctrl-0 = <&i2c0_pins_b>; +
> status = "okay"; + +				ssd1307: oled at 3c { +					compatible =
> "solomon,ssd1307fb-i2c"; +					reg = <0x3c>; +					pwms = <&pwm 4
> 3000>; +					reset-gpios = <&gpio2 7 0>; +				}; +			}; }; };


Would you consider merging this patch?
Andrew Morton merged the driver into its tree
(http://marc.info/?l=linux-fbdev&m=135336761530731&w=2)

Thanks,
Maxime


- -- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCsl7MACgkQGxsu9jQV9nZtJwCfR9c2SnwK1hzAU2F+xptFqg9x
2+0An3YrhNMXSZaPwPcJwc3Bnwy+FSqe
=mjpV
-----END PGP SIGNATURE-----

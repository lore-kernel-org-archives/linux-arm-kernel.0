From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 20 Mar 2016 16:58:38 +0100
Subject: [PATCH v4 1/5] ARM: dts: LG Optimus Black codename sniper basic
 support
In-Reply-To: <20160229215136.GO13417@atomide.com>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
 <1456663185-14170-2-git-send-email-contact@paulk.fr>
 <20160229215136.GO13417@atomide.com>
Message-ID: <1458489518.29161.3.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le lundi 29 f?vrier 2016 ? 13:51 -0800, Tony Lindgren a ?crit?:
> Hi,
> 
> * Paul Kocialkowski <contact@paulk.fr> [160228 04:40]:
> > 
> > The LG Optimus Black codename sniper is a smartphone that was designed and
> > manufactured by LG Electronics (LGE) and released back in 2011.
> > It is using an OMAP3630 SoC, GP version.
> > 
> > This adds devicetree support for the device, with only a few basic features
> > supported, such as debug uart, i2c, internal emmc and external mmc.
> ...
> > 
> > +&i2c1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_pins>;
> > +
> > +	clock-frequency = <2600000>;
> > +
> > +	twl: twl at 48 {
> > +		reg = <0x48>;
> > +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> > +		interrupt-parent = <&intc>;
> > +
> > +		power {
> > +			compatible = "ti,twl4030-power";
> > +			ti,use_poweroff;
> > +		};
> > +	};
> > +};
> Chances are this devices supports cutting off the voltages and
> the high frequency oscillator during idle. So you may want to
> at some point set compatible = "ti,twl4030-power-idle-osc-off"
> here.
> 
> Anyways, applying the dts changes into omap-for-v4.6/dt thanks.

It seems that v3 of this patch was merged into your tree instead of v4, which
contains some improvements over v3.

Should I submit a cleanup patch with the diff or can you use v4 instead (if not
too late)?

Cheers,

-- 
Paul Kocialkowski, low-level free software developer on embedded devices

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160320/5208b283/attachment.sig>

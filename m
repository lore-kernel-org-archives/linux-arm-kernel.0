From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 09 Mar 2015 17:39:29 +0100
Subject: [PATCH 2/2] ARM: dts: hummingboard: Setup pwm lines
In-Reply-To: <20150309154004.GR8656@n2100.arm.linux.org.uk>
References: <E1YSWZL-0002Aw-B5@rmk-PC.arm.linux.org.uk>
 <1425379336.3146.38.camel@pengutronix.de>
 <20150309154004.GR8656@n2100.arm.linux.org.uk>
Message-ID: <1425919169.3152.63.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 09.03.2015, 15:40 +0000 schrieb Russell King - ARM Linux:
> On Tue, Mar 03, 2015 at 11:42:16AM +0100, Philipp Zabel wrote:
> > I wanted to point out these two are superfluous since pwm3/4 are
> > disabled in the dtsi by default, but I just learned they aren't.
> > 
> > Should we add status = "disabled" to unusable (because not externally
> > connected) PWMs, and if so, shouldn't that be done in the dtsi already?
> 
> I guess it should, but we'd first need to ensure that none of the
> existing platforms would break through changing that (eg, through
> a missing status = "okay" entry).

A grep \&pwm arch/arm/boot/dts/imx6* yields:

* imx6dl-aristainetos_4.dts - needs pwm1
* imx6dl-aristainetos_7.dts - needs pwm3
  imx6dl-riotboard.dts - already enables pwm1-4
  imx6dl-tx6dl-comtft.dts - already enables pwm2
  imx6dl-tx6u-801x.dts - pwm2 enabled in imx6qdl-tx6.dtsi
  imx6dl-tx6u-811x.dts - already enables pwm1, pwm2 enabled in imx6qdl-tx6.dtsi
* imx6qdl-cubox-i.dtsi - needs pwm1
  imx6qdl-gw52xx.dtsi - already enables pwm4
  imx6qdl-gw53xx.dtsi - already enables pwm4
  imx6qdl-gw54xx.dtsi - already enables pwm4
  imx6qdl-nitrogen6x.dtsi - already enables pwm1, 3, and 4
  imx6qdl-sabreauto.dtsi - already enables pwm3
  imx6qdl-sabrelite.dtsi - already enables pwm1, 3, and 4
  imx6qdl-sabresd.dtsi - already enables pwm1
  imx6q-tx6q-1010-comtft.dts - pwm2 enabled in imx6qdl-tx6.dtsi
  imx6q-tx6q-1010.dts - pwm2 enabled in imx6qdl-tx6.dtsi
  imx6q-tx6q-1020-comtft.dts - pwm2 enabled in imx6qdl-tx6.dtsi
  imx6q-tx6q-1020.dts - pwm2 enabled in imx6qdl-tx6.dtsi
  imx6q-tx6q-1110.dts - enables pwm1, pwm2 enabled in imx6qdl-tx6.dtsi
  imx6sl-evk.dts - enables pwm1
  imx6sx-sdb.dts - enables pwm3

Did I miss anything? I'll send a patch for those three.

regards
Philipp

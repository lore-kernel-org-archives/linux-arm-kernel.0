From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 26 Feb 2015 20:20:37 +0100 (CET)
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <20150223153812.GA5499@earth>
References: <54C0AFE4.3020701@i2se.com> <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150127001629.GP21293@sirena.org.uk>
 <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
 <20150127194346.GN21293@sirena.org.uk>
 <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150128225937.GA12749@earth.universe>
 <964800678.25817.1422996087477.JavaMail.open-xchange@oxbaltgw04.schlund.de>
 <1766258118.893447.1424429861770.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150223153812.GA5499@earth>
Message-ID: <824878601.106158.1424978437808.JavaMail.open-xchange@oxbsltgw01.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Sebastian Reichel <sre@kernel.org> hat am 23. Februar 2015 um 16:38
> geschrieben:
>
>
> On Fri, Feb 20, 2015 at 11:57:41AM +0100, Stefan Wahren wrote:
> > > power: power at 80044000 {
> > > compatible = "fsl,imx28-power"; /* handled by mxs_power.c */
> > > #address-cells = <1>;
> > > #size-cells = <1>;
> > > reg = <0x80044000 0x2000>;
> > > interrupts = <6>;
> > > switching-frequency = <24000000>; /* new property */
> > > ranges;
> > >
> > > reg_vddd: regulator at 80044040 {
> > > reg = <0x80044040 0x10>,
> > > <0x80044010 0x10>,
> > > <0x800440c0 0x10>;
> > > reg-names = "base-address",
> > > "v5ctrl-address",
> > > "status-address";
> > > compatible = "fsl,imx28-vddd"; /* handled by mxs-regulator.c */
> > > regulator-name = "vddd";
> > > regulator-min-microvolt = <1350000>;
> > > regulator-max-microvolt = <1550000>;
> > > vddd-supply = <&reg_vdda>;
> > > };
> > >
> > > reg_vdda: regulator at 80044050 {
> > > reg = <0x80044050 0x10>,
> > > <0x80044010 0x10>,
> > > <0x800440c0 0x10>;
> > > reg-names = "base-address",
> > > "v5ctrl-address",
> > > "status-address";
> > > compatible = "fsl,imx28-vdda"; /* handled by mxs-regulator.c */
> > > regulator-name = "vdda";
> > > regulator-min-microvolt = <1725000>;
> > > regulator-max-microvolt = <1950000>;
> > > vdda-supply = <&reg_vddio>;
> > > };
> > >
> > > reg_vddio: regulator at 80044060 {
> > > reg = <0x80044060 0x10>,
> > > <0x80044010 0x10>,
> > > <0x800440c0 0x10>;
> > > reg-names = "base-address",
> > > "v5ctrl-address",
> > > "status-address";
> > > compatible = "fsl,imx28-vddio"; /* handled by mxs-regulator.c */
> > > regulator-name = "vddio";
> > > regulator-min-microvolt = <3000000>;
> > > regulator-max-microvolt = <3575000>;
> > > regulator-microvolt-offset = <80000>;
> > > };
> > > };
> > >
> > > Please correct me if i'm wrong.
> > >
> > > Stefan
> >
> > Gentle Ping.
>
> The binding looks ok to me. It would be nice to get an ACK of a DT
> binding maintainer, though.

any objections about implementing DC-DC switching frequency as a DT property
instead of module parameter?

Stefan

From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jan 2017 14:26:35 +0800
Subject: [PATCH 1/2] arm64:dt:ls1046a: Add TMU device tree support for
 LS1046A
In-Reply-To: <AM4PR0401MB1843C415E2CF7D58BD5A1064EB6E0@AM4PR0401MB1843.eurprd04.prod.outlook.com>
References: <1481167706-44234-1-git-send-email-hongtao.jia@nxp.com>
 <20170102062433.GA20956@dragon>
 <AM4PR0401MB1843C415E2CF7D58BD5A1064EB6E0@AM4PR0401MB1843.eurprd04.prod.outlook.com>
Message-ID: <20170103062633.GR20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 03:49:33AM +0000, Troy Jia wrote:
> > > @@ -279,6 +282,82 @@
> > >  			clocks = <&sysclk>;
> > >  		};
> > >
> > > +		tmu: tmu at 1f00000 {
> > > +			compatible = "fsl,qoriq-tmu";
> > > +			reg = <0x0 0x1f00000 0x0 0x10000>;
> > > +			interrupts = <0 33 0x4>;
> > > +			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
> > > +			fsl,tmu-calibration = <0x00000000 0x00000026
> > > +					       0x00000001 0x0000002d
> > > +					       0x00000002 0x00000032
> > > +					       0x00000003 0x00000039
> > > +					       0x00000004 0x0000003f
> > > +					       0x00000005 0x00000046
> > > +					       0x00000006 0x0000004d
> > > +					       0x00000007 0x00000054
> > > +					       0x00000008 0x0000005a
> > > +					       0x00000009 0x00000061
> > > +					       0x0000000a 0x0000006a
> > > +					       0x0000000b 0x00000071
> > > +
> > 
> > Instead of a newline, can we have a single line comment here to tell how these
> > calibration data is grouped?
> 
> Each group represent one temperature range. It's a good idea to add comment here.
> Could I just add one comment like below to clarify all four groups?
> /* Each calibration data group represent one temperature range. There are four ranges in total */

Probably the following form?

	/* Calibration data group 1 */
	...
	/* Calibration data group 2 */
	...
	/* Calibration data group 3 */
	...
	/* Calibration data group 4 */
	...


> 
> > 
> > > +					       0x00010000 0x00000025
> > > +					       0x00010001 0x0000002c
> > > +					       0x00010002 0x00000035
> > > +					       0x00010003 0x0000003d
> > > +					       0x00010004 0x00000045
> > > +					       0x00010005 0x0000004e
> > > +					       0x00010006 0x00000057
> > > +					       0x00010007 0x00000061
> > > +					       0x00010008 0x0000006b
> > > +					       0x00010009 0x00000076
> > > +
> > > +					       0x00020000 0x00000029
> > > +					       0x00020001 0x00000033
> > > +					       0x00020002 0x0000003d
> > > +					       0x00020003 0x00000049
> > > +					       0x00020004 0x00000056
> > > +					       0x00020005 0x00000061
> > > +					       0x00020006 0x0000006d
> > > +
> > > +					       0x00030000 0x00000021
> > > +					       0x00030001 0x0000002a
> > > +					       0x00030002 0x0000003c
> > > +					       0x00030003 0x0000004e>;
> > > +			big-endian;
> > > +			#thermal-sensor-cells = <1>;
> > > +		};
> > > +
> > > +		thermal-zones {
> > > +			cpu_thermal: cpu-thermal {
> > > +				polling-delay-passive = <1000>;
> > > +				polling-delay = <5000>;
> > > +
> > 
> > We usually do not have newline between properties but nodes, or between
> > property list and child node.
> 
> I just follow the style of thermal binding of
> Documentation/devicetree/bindings/thermal/thermal.txt.

Different subsystem or binding examples use different style, but when we
put things together in the platform dts, we would like to have them in a
unified style.

Shawn

From: yangbo.lu@nxp.com (Y.b. Lu)
Date: Mon, 18 Dec 2017 02:51:06 +0000
Subject: [v2] arm: dts: ls1021a: fix the value of TMR_FIPER1
In-Reply-To: <20171130002905.GA22908@dragon>
References: <20171129065458.4235-1-yangbo.lu@nxp.com>
 <20171130002905.GA22908@dragon>
Message-ID: <DB6PR0401MB2536CAFE776097EDEBE82C49F80E0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Sorry for bother. I just couldn?t find this patch on your git tree.
Could you help to check?
Thanks a lot.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2017?11?30? 8:29
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; Mark Rutland <mark.rutland@arm.com>;
> Rob Herring <robh+dt@kernel.org>; Russell King <linux@armlinux.org.uk>
> Subject: Re: [v2] arm: dts: ls1021a: fix the value of TMR_FIPER1
> 
> On Wed, Nov 29, 2017 at 02:54:58PM +0800, Yangbo Lu wrote:
> > The timer fixed interval period pulse generator register is used to
> > generate periodic pulses. The down count register loads the value
> > programmed in the fixed period interval (FIPER). At every tick of the
> > timer accumulator overflow, the counter decrements by the value of
> > TMR_CTRL[TCLK_PERIOD]. It generates a pulse when the down counter
> > value reaches zero. It reloads the down counter in the cycle following
> > a pulse. To use the TMR_FIPER1 register to generate a 1 PPS event, the
> > value
> > (10^9 nanoseconds) - TCLK_PERIOD should be programmed.
> > It should be 999999995 not 999999990 since TCLK_PERIOD is 5.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> 
> 
> Again, for arm dts, we usually use prefix like 'ARM: dts: ...'
> 
> I fixed it up and applied the patch.
> 
> Shawn
> 
> > ---
> > Changes for v2:
> > 	- Added Shawn into cc list.
> > ---
> >  arch/arm/boot/dts/ls1021a.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> > b/arch/arm/boot/dts/ls1021a.dtsi index 64249726b3cb..a861a4b9e319
> > 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -589,7 +589,7 @@
> >  			fsl,tclk-period = <5>;
> >  			fsl,tmr-prsc    = <2>;
> >  			fsl,tmr-add     = <0xaaaaaaab>;
> > -			fsl,tmr-fiper1  = <999999990>;
> > +			fsl,tmr-fiper1  = <999999995>;
> >  			fsl,tmr-fiper2  = <99990>;
> >  			fsl,max-adj     = <499999999>;
> >  		};
> > --
> > 2.14.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flist
> >
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&data=02%7C01%
> 7
> >
> Cyangbo.lu%40nxp.com%7C703a7f8c490745cac3d708d537896a63%7C686ea
> 1d3bc2b
> >
> 4c6fa92cd99c5c301635%7C0%7C0%7C636475985694945094&sdata=XLw6lJ
> ONCoo2jq
> > Hoixb%2BtlYTDcLC4tPbKWT3eQ7RI7c%3D&reserved=0

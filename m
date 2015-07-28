From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Tue, 28 Jul 2015 02:01:33 +0000
Subject: [PATCH v2] ARM: dts: ls1021a: add wakeup device ftm0 node for
 ls1021a
In-Reply-To: <20150728014946.GY12927@tiger>
References: <1436946011-30113-1-git-send-email-b18965@freescale.com>
 <20150728014946.GY12927@tiger>
Message-ID: <SN1PR0301MB1616D470C96F8D09028C13259D8D0@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Tuesday, July 28, 2015 9:50 AM
> To: Wang Huan-B18965
> Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Wang Dongsheng-B40534; Wang Huan-B18965
> Subject: Re: [PATCH v2] ARM: dts: ls1021a: add wakeup device ftm0 node for
> ls1021a
> 
> On Wed, Jul 15, 2015 at 03:40:11PM +0800, Alison Wang wrote:
> > Add ftm0 node, cause of ftm0 can be set as a alarm before system going
> > to deep sleep.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> > ---
> > Changes since v1:
> > - Add my SoB.
> > - Use "ARM:" as subject prefix.
> >
> >  arch/arm/boot/dts/ls1021a-qds.dts | 4 ++++
> >  arch/arm/boot/dts/ls1021a.dtsi    | 8 ++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a-qds.dts
> > b/arch/arm/boot/dts/ls1021a-qds.dts
> > index 9c5e16b..f14731b 100644
> > --- a/arch/arm/boot/dts/ls1021a-qds.dts
> > +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> > @@ -75,6 +75,10 @@
> >  	};
> >  };
> >
> > +&ftm0 {
> > +	status = "okay";
> > +};
> > +
> >  &i2c0 {
> >  	status = "okay";
> >
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> > b/arch/arm/boot/dts/ls1021a.dtsi index c70bb27..7e9e122 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -332,6 +332,14 @@
> >  			status = "disabled";
> >  		};
> >
> > +		ftm0: ftm0 at 29d0000 {
> 
> Is the '0' in the node name is an instance number?  If so, please drop it from
> node name.

"0" is a special number for FTM, because there is only ftm0 can be maked as a alarm timer.

Regards,
-Dongsheng

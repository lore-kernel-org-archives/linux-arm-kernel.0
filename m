From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Tue, 7 Aug 2012 11:40:40 +0000
Subject: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
In-Reply-To: <501B6F99.4020506@ti.com>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
 <1343219012-19472-2-git-send-email-anilkumar@ti.com>
 <501B6F99.4020506@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA0D423@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav,

Thanks for the review.

On Fri, Aug 03, 2012 at 11:58:41, Hiremath, Vaibhav wrote:
> 
> 
> On 7/25/2012 5:53 PM, AnilKumar Ch wrote:
> > Add Bosch D_CAN controller device tree data to AM33XX dtsi file
> > by adding d_can device node with all the necessary parameters.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/boot/dts/am33xx.dtsi |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index 9b974dc..2db2ffb 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -163,5 +163,10 @@
> >  			#size-cells = <0>;
> >  			ti,hwmods = "i2c3";
> >  		};
> > +
> > +		dcan1: d_can at 481D0000 {
> > +			compatible = "bosch,d_can";
> > +			ti,hwmods = "d_can1";
> > +		};
> 
> Anil,
> 
> Any reason why we are only specifying dcan1 instance? Shouldn't we
> specify dcan0 as well here?
> 

Yes, I agree dcan0 needs to add because SoC support two instances. I
have added d_can1 only because on AM335x-EVM d_can1 is available and
in other case AM335x-bone have two instances available. I will send next
version of these patches.

Regards
AnilKumar

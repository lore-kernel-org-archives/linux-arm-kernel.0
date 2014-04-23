From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 23 Apr 2014 19:36:31 +0200
Subject: [PATCH v2 2/2] ARM: dts: berlin: enable SD card reader and eMMC
 for the BG2Q DMP
In-Reply-To: <5357F7BF.8000703@gmail.com>
References: <1398155248-1659-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398155248-1659-3-git-send-email-antoine.tenart@free-electrons.com>
 <5357F7BF.8000703@gmail.com>
Message-ID: <20140423173631.GA10464@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Wed, Apr 23, 2014 at 07:26:23PM +0200, Sebastian Hesselbarth wrote:
> On 04/22/2014 10:27 AM, Antoine T?nart wrote:
> > Enable the SD Card reader and the internal eMMC on the Berlin BG2Q DMP
> > using two of the SDHCI nodes of the Berlin BG2Q.
> > 
> > Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> > index 2da9c41e29d8..6ca8c9e52b08 100644
> > --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> > +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> > @@ -26,3 +26,14 @@
> >  &uart0 {
> >  	status = "okay";
> >  };
> > +
> > +&sdhci1 {
> 
> Antoine,
> 
> nit: please sort referenced nodes alphabetically.
> 
> With your comments about mmc aliases, I can take both patches
> in now (and fixup ordering) if you like.

You can take them.

I talked with Jisheng about this and the plan is to make a following up
series for the aliases since it will require to modify the subsystem.

Thanks!

Antoine

> 
> Sebastian
> 
> > +	broken-cd;
> > +	sdhci,wp-inverted;
> > +	status = "okay";
> > +};
> > +
> > +&sdhci2 {
> > +	non-removable;
> > +	status = "okay";
> > +};
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

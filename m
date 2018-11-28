From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Nov 2018 16:53:39 +0800
Subject: [PATCH 1/3] ARM: dts: imx1: Fix memory node duplicaton
In-Reply-To: <7a0bd2b6-a624-85f0-6b63-ae2f80907685@mentor.com>
References: <1543236054-10450-1-git-send-email-festevam@gmail.com>
 <7a0bd2b6-a624-85f0-6b63-ae2f80907685@mentor.com>
Message-ID: <20181128085337.GP20643@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 03:13:24PM +0200, Vladimir Zapolskiy wrote:
> Hi Fabio,
> 
> On 11/26/2018 02:40 PM, Fabio Estevam wrote:
> > Boards based on imx1 have duplicate memory nodes:
> > 
> > - One coming from the board dts file: memory@
> > 
> > - One coming from the imx1.dtsi file.
> > 
> > Fix the duplication by removing the memory node from the dtsi file
> > and by adding 'device_type = "memory";' in the board dts.
> > 
> > Reported-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > ---
> >  arch/arm/boot/dts/imx1-ads.dts     | 1 +
> >  arch/arm/boot/dts/imx1-apf9328.dts | 1 +
> >  arch/arm/boot/dts/imx1.dtsi        | 2 --
> >  3 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
> > index a1d81ba..3459a58 100644
> > --- a/arch/arm/boot/dts/imx1-ads.dts
> > +++ b/arch/arm/boot/dts/imx1-ads.dts
> > @@ -21,6 +21,7 @@
> >  	};
> >  
> >  	memory at 8000000 {
> > +		 device_type = "memory";
> >  		reg = <0x08000000 0x04000000>;
> 
> there is an unwanted space symbol before 'device_type'.

I fixed it up and applied the series.

Shawn

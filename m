From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 4 May 2017 21:18:07 +0800
Subject: [PATCH 1/3] ARM: dts: imx6qdl-nitrogen6_max: fix rv4162 compatible
In-Reply-To: <20170503221620.k3gf3s7lramlgfyf@piout.net>
References: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
 <20170503085010.GF18578@dragon>
 <20170503221620.k3gf3s7lramlgfyf@piout.net>
Message-ID: <20170504131806.GQ18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 12:16:20AM +0200, Alexandre Belloni wrote:
> On 03/05/2017 at 16:50:12 +0800, Shawn Guo wrote:
> > On Wed, Apr 19, 2017 at 10:22:02PM +0200, Alexandre Belloni wrote:
> > > The rv4162 vendor is microcrystal, not ST.
> > > 
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > ---
> > >  arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> > > index bad3c9f9eeac..b63134e3b51a 100644
> > > --- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> > > +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> > > @@ -408,7 +408,7 @@
> > >  	};
> > >  
> > >  	rtc: rtc at 68 {
> > > -		compatible = "st,rv4162";
> > > +		compatible = "microcrystal,rv4162";
> > 
> > The compatible is not documented?
> > 
> 
> No, it wasn't. Like for many i2c devices, the driver predates DT and
> didn't need any specific code to be used from DT. Basically, the i2c
> core was using the i2c_device_ids to match the DT compatible string.
> This is changing since cabcf4f6be658b2d4bea26dee89d08fdf67d6811.
> 
> I'm planning to document all the undocumented ones soon.

I applied all 3 patches.  Please remember to document the compatible.

Shawn

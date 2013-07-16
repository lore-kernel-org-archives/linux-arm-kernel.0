From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Jul 2013 05:24:32 -0700
Subject: [PATCH 2/4] arm: omap5: hwmod: add missing ocp2scp hwmod data
In-Reply-To: <20130715154603.GC32035@arwen.pp.htv.fi>
References: <1373902423-28654-1-git-send-email-balbi@ti.com>
 <1373902423-28654-3-git-send-email-balbi@ti.com>
 <51E418A4.9000109@ti.com> <20130715154603.GC32035@arwen.pp.htv.fi>
Message-ID: <20130716122432.GX7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130715 08:52]:
> On Mon, Jul 15, 2013 at 09:13:32PM +0530, Kishon Vijay Abraham I wrote:
> > Hi,
> > 
> > On Monday 15 July 2013 09:03 PM, Felipe Balbi wrote:
> > > From: Benoit Cousson <benoit.cousson@linaro.org>
> > > 
> > > without that hwmod data, USB3 will not in OMAP5 boards.
> > > 
> > > While at that, also fix DTS data to pass reg property,
> > > otherwise driver won't probe.
> > > 
> > > Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  arch/arm/boot/dts/omap5.dtsi               |  3 +-
> > >  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 45 ++++++++++++++++++++++++++++++
> > >  2 files changed, 47 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> > > index 5c99f19..4e41409 100644
> > > --- a/arch/arm/boot/dts/omap5.dtsi
> > > +++ b/arch/arm/boot/dts/omap5.dtsi
> > > @@ -652,10 +652,11 @@
> > >  			};
> > >  		};
> > >  
> > > -		ocp2scp {
> > > +		ocp2scp at 4a080000 {
> > 
> > While at that, can we also name it ocp2scp1 since we have 3 instances of
> > ocp2scp and it'll conflict when we want to add it for SATA and PCIE.

Hmm the differentiatior is the name, so ocp2scp at 4a800000 should
be enough and actually follows the naming standars where the name
should describe the type. I guess it could be just ocp at 4a080000
or scp at 4a080000 but I think it translates both ways, so ocp2scp
is probably pretty good.
 
> Tony/Benoit, you want that in same patch or as a separate patch
> altogether ?

Please do the .dts changes in separate patches as they should
get merged separately for most part.

Regards,

Tony

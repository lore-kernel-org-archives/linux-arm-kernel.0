From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 00:43:48 -0700
Subject: [PATCH RESEND v2 1/2] arm/dts: Add AM33XX basic pinctrl support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA06E4B@DBDE01.ent.ti.com>
References: <1343144719-26352-1-git-send-email-anilkumar@ti.com>
 <1343144719-26352-2-git-send-email-anilkumar@ti.com>
 <50125B1C.8000209@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA06E4B@DBDE01.ent.ti.com>
Message-ID: <20120807074348.GQ11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar, Chimata <anilkumar@ti.com> [120731 06:37]:
> Hi Peter,
> 
> On Fri, Jul 27, 2012 at 14:40:52, Ujfalusi, Peter wrote:
> > Hi,
> > 
> > On 07/24/2012 06:45 PM, AnilKumar Ch wrote:
> > > Adds basic pinctrl support for AM33XX family of devices. This patch
> > > is based on the pinctrl-simple driver submitted by Tony Lindgren's
> > > here: http://lwn.net/Articles/496075/
> > > 
> > > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > > ---
> > >  arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > > index 59509c4..9b974dc 100644
> > > --- a/arch/arm/boot/dts/am33xx.dtsi
> > > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > > @@ -40,6 +40,15 @@
> > >  		};
> > >  	};
> > >  
> > > +	am3358_pinmux: pinmux at 44E10800 {
> > > +		compatible = "pinctrl-single";
> > > +		reg = <0x44E10800 0x0338>;
> > 
> > I'm just curious about the size here: how it ended up as 0x0338?
> > While looking at the TRM of AM335x I can come up with 0x0238 (0x44e10800 -
> > 0x44e10a38), but I don't see any sings of the remaining 0x0100 to be
> > documented at least.
> 
> No, pinmux registers are available till 0x44E10B38, look at AM335x latest TRM
> or pinmux utility (we cannot find the exact offsets but pins we can find after
> 0x0A38, conf_ddr_resetn) at http://www.ti.com/tool/pinmuxtool

If you have a hole inbetween the registers it sounds like you also have core and
wkup domains? In that case those should be set up as separate controllers as other
SCM registers may be inbetween those domains.

Tony

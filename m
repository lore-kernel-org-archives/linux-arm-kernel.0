From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 8 Jan 2012 17:47:38 +0800
Subject: [PATCH 3/6] arm/dts: imx6q-sabrelite: add 2P5V and 3P3V regulators
In-Reply-To: <20120108091402.GA2203@richard-laptop>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-4-git-send-email-richard.zhao@linaro.org>
 <20120108090619.GB20216@S2101-09.ap.freescale.net>
 <20120108091402.GA2203@richard-laptop>
Message-ID: <20120108094736.GC20216@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 05:14:05PM +0800, Richard Zhao wrote:
> On Sun, Jan 08, 2012 at 05:06:21PM +0800, Shawn Guo wrote:
> > For subject, I would suggest something like below to keep consistency
> > with code patches.
> > 
> > ARM: dts: imx6q-sabrelite: ...
> ok
> > 
> > On Fri, Jan 06, 2012 at 11:25:40AM +0800, Richard Zhao wrote:
> > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > ---
> > >  arch/arm/boot/dts/imx6q-sabrelite.dts |   20 ++++++++++++++++++++
> > >  1 files changed, 20 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > > index 08d920d..3f4b45e 100644
> > > --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > > @@ -46,4 +46,24 @@
> > >  			};
> > >  		};
> > >  	};
> > > +
> > > +	regulators {
> > 
> > Shouldn't this node be under node 'anatop at 020c8000'?
> It's LDOs on board. Why do I put it in anatop?

Sorry, I messed up here.

> > 
> > > +		compatible = "simple-bus";
> > > +
> > Hmm, do we really need this?
> If I don't set it, the regulator devices will not be populated.

ditto

> > 
> > > +		reg_2P5V: regulator-2P5V {
> > 
> > There is convention that we should try to have all kinds of names in dts
> > as lower case, even though hardware document generally names blocks in
> > capital letters.  It just looks odd to have mixed cases in the name.
> The convention looks weird. The dts is supposed to reflect hw as much
> as possible. I'll change it if you insist.

Yes, please.

> > 
> > Since the node is under node 'regulators', we may name the node just
> > as simple as '2p5v'.
> I was just not sure whether the name can start with digit. If yes, I'm
> glad to make it short.

I just gave a quick try, and it works.

Regards,
Shawn

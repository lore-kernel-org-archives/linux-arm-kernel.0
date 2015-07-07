From: koro.chen@mediatek.com (Koro Chen)
Date: Tue, 7 Jul 2015 17:20:09 +0800
Subject: [PATCH] arm64: dts: mt8173: Add afe device node
In-Reply-To: <25205102.t939MQMDBD@ubix>
References: <1436165530-41963-1-git-send-email-koro.chen@mediatek.com>
 <CAGS+omCOzJs=VWboU_7doUum6BEfmh1hV88HmJiin2c-A_n_Mw@mail.gmail.com>
 <25205102.t939MQMDBD@ubix>
Message-ID: <1436260809.4347.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-07 at 09:46 +0200, Matthias Brugger wrote:
> On Monday, July 06, 2015 09:02:38 PM Daniel Kurtz wrote:
> > On Mon, Jul 6, 2015 at 2:52 PM, Koro Chen <koro.chen@mediatek.com> wrote:
> > > This adds afe (audio front end) device node to the MT8173 dtsi file.
> > > 
> > > This patch is based on Matthias's tree:
> > > https://github.com/mbgg/linux-mediatek
> > > branch: v4.2-next/arm64
> > > 
> > > Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> > > ---
> > > 
> > >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 32
> > >  ++++++++++++++++++++++++++++++++ 1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > > b/arch/arm64/boot/dts/mediatek/mt8173.dtsi index 0696f8f..f8afab4 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > > @@ -14,6 +14,7 @@
> > > 
> > >  #include <dt-bindings/clock/mt8173-clk.h>
> > >  #include <dt-bindings/interrupt-controller/irq.h>
> > >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > 
> > > +#include <dt-bindings/power/mt8173-power.h>
> > > 
> > >  #include <dt-bindings/reset-controller/mt8173-resets.h>
> > >  #include "mt8173-pinfunc.h"
> > > 
> > > @@ -393,6 +394,37 @@
> > > 
> > >                         #size-cells = <0>;
> > >                         status = "disabled";
> > >                 
> > >                 };
> > > 
> > > +
> > > +               afe: mt8173-afe-pcm at 11220000  {
> > 
> > I believe this should be something generic, like:
> > 
> >   afe: audio-controller at 11220000
> > 
> 
> Yes, please find a name that better describes the component instead of just 
> using the compatible string.
> 
Thanks both, I will change the name to audio-controller.

> Thanks.
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 17 Jan 2014 12:01:19 +0100
Subject: [PATCH 09/11] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000
In-Reply-To: <CAL_JsqK2JUBEvCb-=eHFE_T=2AD0K_+V=NAeijzK2DrCwkaCOA@mail.gmail.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-10-git-send-email-andreas.herrmann@calxeda.com>
 <CAL_JsqK2JUBEvCb-=eHFE_T=2AD0K_+V=NAeijzK2DrCwkaCOA@mail.gmail.com>
Message-ID: <20140117110108.GV3471@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 09:30:26AM -0500, Rob Herring wrote:
> On Thu, Jan 16, 2014 at 6:44 AM, Andreas Herrmann
> <andreas.herrmann@calxeda.com> wrote:
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> 
> One minor comment, but otherwise:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> > ---
> >  arch/arm/boot/dts/ecx-2000.dts    |   44 +++++++++++++++++++++++++++++++++++--
> >  arch/arm/boot/dts/ecx-common.dtsi |    9 +++++---
> >  2 files changed, 48 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
> > index 2ccbb57f..722de49 100644
> > --- a/arch/arm/boot/dts/ecx-2000.dts
> > +++ b/arch/arm/boot/dts/ecx-2000.dts
> > @@ -76,10 +76,11 @@
> >         };
> >
> >         soc {
> > -               ranges = <0x00000000 0x00000000 0x00000000 0xffffffff>;
> > +               ranges = <0x0 0x0 0x0 0xffffffff>;
> >
> >                 timer {
> > -                       compatible = "arm,cortex-a15-timer", "arm,armv7-timer";                         interrupts = <1 13 0xf08>,
> > +                       compatible = "arm,cortex-a15-timer", "arm,armv7-timer";
> > +                       interrupts = <1 13 0xf08>,
> >                                 <1 14 0xf08>,
> >                                 <1 11 0xf08>,
> >                                 <1 10 0xf08>;
> > @@ -109,6 +110,45 @@
> >                         interrupts = <0 76 4  0 75 4  0 74 4  0 73 4>;
> >                 };
> >         };
> > +
> > +       soc at 920000000 {
> 
> I believe this and the other > 32-bit addresses below should be
> "soc at 9,20000000".

Will fix this.


Thanks,

Andreas

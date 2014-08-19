From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 08:11:50 +0900
Subject: [PATCH v2 1/5] ARM: shmobile: r8a7740: Add CMT1 device to DT
In-Reply-To: <CANqRtoQ-g906KNRGjx_6nuX_E8COSunXMDZQUZkPUFzBUTZFgA@mail.gmail.com>
References: <1407801882-2561-1-git-send-email-horms+renesas@verge.net.au>
 <1407801882-2561-2-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTBJOZEFoOg+YmfyovCGDTa43Qs77OW-qd9YQLFq3tQ3A@mail.gmail.com>
 <CAMuHMdXTa8dG0L2xLNELn3R310PJc+HotHwJZsaqPzuWQRJf5A@mail.gmail.com>
 <CANqRtoQ-g906KNRGjx_6nuX_E8COSunXMDZQUZkPUFzBUTZFgA@mail.gmail.com>
Message-ID: <20140819231144.GA27115@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 07:17:33PM +0900, Magnus Damm wrote:
> On Tue, Aug 19, 2014 at 4:29 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Aug 19, 2014 at 8:39 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >>>  arch/arm/boot/dts/r8a7740.dtsi | 12 ++++++++++++
> >>>  1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> >>> index 6cd6a46..1067a96 100644
> >>> --- a/arch/arm/boot/dts/r8a7740.dtsi
> >>> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> >>> @@ -41,6 +41,18 @@
> >>>                 interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
> >>>         };
> >>>
> >>> +       cmt1: timer at e6138000 {
> >>> +               compatible = "renesas,cmt-48";
> >>
> >> Do we want to have the "r8a7740" in the compatible string somewhere?
> >
> > Documentation/devicetree/bindings/timer/renesas,cmt.txt does not
> > mention compatible properties containing SoC names.
> 
> Right, that seems to be missing from the timers. Is there any reason
> why we need to treat those in a special way?
> 
> In my mind this timer case is similar to various SCIF variants
> documented in Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> - in the case of SCIF we have SoC name in the binding documentation.

FWIW, now you mention it I agree with your point.
But I am interested to hear if Laurent had a specific reason for this.

If it is an oversight then I recommend correcting it as a series
of add-on patches, even for the r8a7740. That will avoid adding
more dependencies to this series.

From: horms@verge.net.au (Simon Horman)
Date: Thu, 12 Nov 2015 10:24:58 +0900
Subject: [PATCH 1/3] ARM: shmobile: r8a7793: Add DMAC devices to DT
In-Reply-To: <CANqRtoRURHDbWS7cm5b_385D0cs=gdtHErapGTki7eYbjqeZxg@mail.gmail.com>
References: <1447139641-11480-1-git-send-email-horms+renesas@verge.net.au>
 <1447139641-11480-2-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoRURHDbWS7cm5b_385D0cs=gdtHErapGTki7eYbjqeZxg@mail.gmail.com>
Message-ID: <20151112012458.GC19649@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 01:58:09AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Tue, Nov 10, 2015 at 4:13 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Instantiate the two system DMA controllers in the r8a7793 device tree.
> >
> > Based on similar work for the r8a7793 by Laurent Pinchart.
> >
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a7793.dtsi | 72 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> > index 4f6480f8845f..187a82dc7d9f 100644
> > --- a/arch/arm/boot/dts/r8a7793.dtsi
> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
> > @@ -128,6 +128,68 @@
> >                 #gpio-range-cells = <3>;
> >         };
> >
> > +       dmac0: dma-controller at e6700000 {
> > +               compatible = "renesas,rcar-dmac";
> 
> Thanks for cooking up this patch. It looks fine to me, but it reminds
> me about compat string handling.
> 
> Is there any special reason why we don't use the SoC part number in
> the compatible string for DMAC devices?

Thanks. I will try and resolve that separately to this patchset.

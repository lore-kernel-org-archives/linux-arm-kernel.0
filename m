From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Oct 2017 10:47:40 +0200
Subject: [PATCH 07/20] ARM: dts: sun4i: Remove skeleton and memory to
 avoid warnings
In-Reply-To: <CAGb2v66LnQB1jqU5BWNEYjws3YLVBndLf8-ofLE+6JgZ1GtnXA@mail.gmail.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <b1acecf3049f3bc96266f2db22149bf0b18e7a30.1507198895.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v66LnQB1jqU5BWNEYjws3YLVBndLf8-ofLE+6JgZ1GtnXA@mail.gmail.com>
Message-ID: <20171006084740.5g7tavojdghn7cma@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 03:43:53PM +0000, Chen-Yu Tsai wrote:
> On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Using skeleton.dtsi will create a memory node that will generate a warning
> > in DTC. However, that node will be created by the bootloader, so we can
> > just remove it entirely in order to remove that warning.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> > index 1876abb62ec7..f64544f615ea 100644
> > --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> > +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> > @@ -41,14 +41,14 @@
> >   *     OTHER DEALINGS IN THE SOFTWARE.
> >   */
> >
> > -#include "skeleton.dtsi"
> > -
> >  #include <dt-bindings/thermal/thermal.h>
> >  #include <dt-bindings/dma/sun4i-a10.h>
> >  #include <dt-bindings/clock/sun4i-a10-ccu.h>
> >  #include <dt-bindings/reset/sun4i-a10-ccu.h>
> >
> >  / {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> >         interrupt-parent = <&intc>;
> >
> >         aliases {
> > @@ -160,10 +160,6 @@
> >                 };
> >         };
> >
> > -       memory {
> > -               reg = <0x40000000 0x80000000>;
> > -       };
> > -
> 
> My only concern (I'm not sure if it's valid or not) is U-boot not being
> able to add nodes or properties due to lack of space within the DT
> blob. It seemed like a possibility in older versions.
> 
> Otherwise,
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

I don't think we really have to worry about it. We've had a bunch of
nodes (like the PSCI nodes) created in the same way for quite some
time already without causing any issues.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171006/08188b7f/attachment-0001.sig>

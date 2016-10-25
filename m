From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Oct 2016 12:42:09 +0200
Subject: [PATCH 5/8] ARM: gr8: Add missing pwm channel 1 pin
In-Reply-To: <CAGb2v64Ai+8sUPyH9aTnKUw1ROmQNxzCEqUXrT4v8Q-nipqR3Q@mail.gmail.com>
References: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
 <0df42247c3348e7f6aed945e5669cec87f96f7ac.1476951078.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v66w0sTzn_SWH4rrpWKOosSxALV8ot3CBQbGhwLxvX1vxw@mail.gmail.com>
 <20161020170739.lgt2ywm346vm47zd@lukather>
 <CAGb2v64Ai+8sUPyH9aTnKUw1ROmQNxzCEqUXrT4v8Q-nipqR3Q@mail.gmail.com>
Message-ID: <20161025104209.edtqoymu4thc56p4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 12:10:26PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 21, 2016 at 1:07 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Thu, Oct 20, 2016 at 10:10:03PM +0800, Chen-Yu Tsai wrote:
> >> On Thu, Oct 20, 2016 at 4:12 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > The PWM controller has two different channels, but only the first pin was
> >> > exposed in the DTSI. Add the other one.
> >> >
> >> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>
> >> Acked-by: Chen-Yu Tsai <wens@csie.org>
> >>
> >> > ---
> >> >  arch/arm/boot/dts/ntc-gr8.dtsi | 7 +++++++
> >> >  1 file changed, 7 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
> >> > index 74aff795e723..fad7381630f3 100644
> >> > --- a/arch/arm/boot/dts/ntc-gr8.dtsi
> >> > +++ b/arch/arm/boot/dts/ntc-gr8.dtsi
> >> > @@ -854,6 +854,13 @@
> >> >                                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> >                         };
> >> >
> >> > +                       pwm1_pins_a: pwm1 at 0 {
> >>
> >> Nit: really don't need "_a" and "@0" here.
> >
> > Fixed and applied.
> 
> Oops, you forgot to fix the label in the chip-pro dts:
> 
>   DTC     arch/arm/boot/dts/ntc-gr8-chip-pro.dtb
> ERROR (phandle_references): Reference to non-existent node or label
> "pwm1_pins_a"
> 
> ERROR: Input tree has errors, aborting (use -f to force output)
> scripts/Makefile.lib:313: recipe for target
> 'arch/arm/boot/dts/ntc-gr8-chip-pro.dtb' failed

Yeah, it was noticed by linux-next too, and I fixed it...

Sorry for that.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161025/7c71abee/attachment.sig>

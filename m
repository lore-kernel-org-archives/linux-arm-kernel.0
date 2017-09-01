From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Sep 2017 15:16:24 +0200
Subject: [PATCH 4/5] arm: dts: sun8i: a83t: Add the UART1 controller
In-Reply-To: <CAGb2v64q8prGOAP_5g3PxTs1La0662kpETy2BTr60Ak4FbrY6Q@mail.gmail.com>
References: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
 <20170825092617.32533-4-maxime.ripard@free-electrons.com>
 <CAGb2v64q8prGOAP_5g3PxTs1La0662kpETy2BTr60Ak4FbrY6Q@mail.gmail.com>
Message-ID: <20170901131624.zl3os327ock2qtyy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 02:48:20PM +0800, Chen-Yu Tsai wrote:
> On Fri, Aug 25, 2017 at 5:26 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A83T has an UART1 controller, with the RTS and CTS pins routed so it
> > can be used for devices with hardware flow control, like a bluetooth chip.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > index 91dee798f3ca..f6aaaa9a1fe2 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > @@ -373,6 +373,16 @@
> >                                 pins = "PF2", "PF4";
> >                                 function = "uart0";
> >                         };
> > +
> > +                       uart1_pg_pins: uart1-pg-pins {
> 
> Since uart1 is only available on the PG pin group, this name
> doesn't provide much info. Instead lets name it uart1_rxtx_pins.
> This matches the naming scheme for the rts/cts pingroup.

I've fixed it and applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/2d7c2229/attachment.sig>

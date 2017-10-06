From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Oct 2017 11:26:35 +0200
Subject: [PATCH 08/20] ARM: dts: sun4i: Change LRADC node names to avoid
 warnings
In-Reply-To: <CAGb2v65LTUN4a=BzB7hgE7g=4qH6bFLp3WyWJxPrPoVXp0seVw@mail.gmail.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <14fb41e6a5648f99643629b1dc9df9ef04c01fbd.1507198895.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65LTUN4a=BzB7hgE7g=4qH6bFLp3WyWJxPrPoVXp0seVw@mail.gmail.com>
Message-ID: <20171006092635.eeynkeoxgbj3c27f@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 03:52:29PM +0000, Chen-Yu Tsai wrote:
> On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > One of the usage of the LRADC is to implement buttons. The bindings define
> > that we should have one subnode per button, with their associated voltage
> > as a property.
> >
> > However, there was no reg property but we still used the voltage associated
> > to the button as the unit-address, which eventually generated warnings in
> > DTC.
> >
> > Rename the node names to avoid those warnings.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts  |  6 +++---
> >  arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts |  4 ++--
> >  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts         |  6 +++---
> >  arch/arm/boot/dts/sun4i-a10-inet1.dts            |  6 +++---
> >  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        | 10 +++++-----
> >  arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts     | 10 +++++-----
> >  arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts |  4 ++--
> >  7 files changed, 23 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> > index 4978e46ca620..b2dbdac19c0f 100644
> > --- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> > +++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> > @@ -98,21 +98,21 @@
> >         vref-supply = <&reg_vcc3v0>;
> >         status = "okay";
> >
> > -       button at 800 {
> > +       button-800 {
> 
> I think 800mV-button would be better, i.e. have the "generic"
> part of the name as a suffix.

It would go against most of the convention that we have everywhere
else for framebuffers, pin muxings, or even regular node names that
start with the class, and then have the most specific part.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171006/09fef6eb/attachment.sig>

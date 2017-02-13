From: plaes@plaes.org (Priit Laes)
Date: Mon, 13 Feb 2017 18:46:45 +0200
Subject: [linux-sunxi] Re: [PATCH 2/8] ARM: sun4i: Add display blocks
 for the sun4i dtsi.
In-Reply-To: <CAGb2v648uAKxpYaU_qhTLAyfe5snW1LG1VWmm+UMLRSQ5a7DKg@mail.gmail.com>
References: <20170211174405.28395-1-plaes@plaes.org>
 <20170211174405.28395-3-plaes@plaes.org>
 <20170213091612.d5ifc4oi63xf7boi@lukather>
 <CAGb2v648uAKxpYaU_qhTLAyfe5snW1LG1VWmm+UMLRSQ5a7DKg@mail.gmail.com>
Message-ID: <1487004405.20308.3.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-02-13 at 17:20 +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 13, 2017 at 5:16 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> > 
> > On Sat, Feb 11, 2017 at 07:43:59PM +0200, Priit Laes wrote:
> > > Added basic display pipeline consisting of tcon, display backend
> > > and
> > > frontend blocks.
> > > 
> > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > > ---
> > > ?arch/arm/boot/dts/sun4i-a10.dtsi | 104
> > > +++++++++++++++++++++++++++++++++++++++
> > > ?1 file changed, 104 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi
> > > b/arch/arm/boot/dts/sun4i-a10.dtsi
> > > index ba20b48..70991c9 100644
> > > --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> > > +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> > > @@ -779,6 +779,45 @@
> > > ??????????????????????#size-cells = <0>;
> > > ??????????????};
> > > 
> > > +?????????????tcon0: lcd-controller at 1c0c000 {
> > > +?????????????????????compatible = "allwinner,sun5i-a13-tcon";
> > 
> > There's a few bits here and there that need to be setup differently
> > in
> > A10, so you cannot reuse that compatible (same thing for the
> > other).
> > 
> > Also, I'd really like to have all the blocks listed here, and not
> > only
> > the first pipeline. Ideally, on the A10, the two pipelines should
> > be
> > enabled too.
> 
> The display pipeline driver has to be fixed before that can happen
> though. And I haven't started to work on what I proposed yet. Though
> if someone wants to take over I can forward any design plans I have.

Well, my plan was to get at least minimum bits mainlined and then build
additional features on top.

Wens, it would be cool though, if you could share your plans.

Unfortunately I have only single A10 device (with LVDS and mini-HDMI)
but I don't actually have other LVDS-displays I could easily use with
A20 devices (I have CubieTruck and A20-Olinuxino Micro).

P?ikest,
Priit :)

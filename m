From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:41:29 +0100
Subject: [PATCH 31/77] ARM: dts: sun6i: Change pinctrl nodes to avoid
 warning
In-Reply-To: <CAGb2v65taoS1H9PmJBtUvkq13Rdn4WdZr7+pTGNM-UDfgg8DWA@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <288a28fa42f816b4f255a316569e7f750c3e73ac.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v65taoS1H9PmJBtUvkq13Rdn4WdZr7+pTGNM-UDfgg8DWA@mail.gmail.com>
Message-ID: <20181128134129.rg3j4zgliwv4owpl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:50:31PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > All our pinctrl nodes were using a node name convention with a unit-address
> > to differentiate the different muxing options. However, since those nodes
> > didn't have a reg property, they were generating warnings in DTC.
> >
> > In order to accomodate for this, convert the old nodes to the syntax we've
> > been using for the new SoCs, including removing the letter suffix of the
> > node labels to the bank of those pins to make things more readable.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> [...]
> 
> > diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> > index c5fd97b88b90..596ab854da2c 100644
> > --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> > +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> 
> [...]
> 
> > @@ -712,12 +712,12 @@
> >                                 bias-pull-up;
> >                         };
> >
> > -                       spdif_pins_a: spdif at 0 {
> > +                       spdif_tx_pin: spdif-pin {
> 
> Node name should be spdif-tx-pin, since this SoC also has
> SPDIF input.
> 
> Otherwise,
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

I fixed it up while applying, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/c7138bab/attachment-0001.sig>

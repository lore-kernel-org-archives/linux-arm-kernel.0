From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:59:31 +0100
Subject: [PATCH 58/77] ARM: dts: sun8i: a23/a33: Remove redundant MMC
 pinmux tuning
In-Reply-To: <CAGb2v67H0pAODp2dixSi-cjhMiBcc_YwoKkCxf4msZ4522A88A@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <d856497c2ad879816c6f944128bc62371f604f7a.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v67H0pAODp2dixSi-cjhMiBcc_YwoKkCxf4msZ4522A88A@mail.gmail.com>
Message-ID: <20181128135931.dpmuqpzz5wayucv3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 28, 2018 at 08:36:33PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Some boards override the MMC pin muxing settings in order to enable the
> > pull-ups and change the drive strength to a value higher than the default.
> >
> > While this was needed in the earlier days, this is now the default setting
> > for those pins, and therefore we don't need those board-specific settings
> > anymore.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts | 4 ----
> >  arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts | 4 ----
> >  arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts        | 4 ----
> >  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts        | 7 -------
> >  arch/arm/boot/dts/sun8i-q8-common.dtsi                | 4 ----
> >  arch/arm/boot/dts/sun8i-r16-parrot.dts                | 5 -----
> >  6 files changed, 28 deletions(-)
> >
> 
> [...]
> 
> > diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> > index b343153948f4..7e006d0fbf27 100644
> > --- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> > +++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> > @@ -151,13 +151,6 @@
> >         status = "okay";
> >  };
> >
> > -&mmc2_8bit_pins {
> > -       /* Increase drive strength for DDR modes */
> > -       drive-strength = <40>;
> 
> This is not the default. Maybe we should make it the default?

IIRC, you looked into the emmc standard some time ago, and you
concluded that the default was 30mA.

I don't really want to make it the default if only a couple of boards
need it though. I've droped that part from the patch.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/8b1e2841/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Oct 2017 10:45:27 +0200
Subject: [PATCH 05/20] ARM: dts: sun4i: Change pinctrl nodes to avoid
 warning
In-Reply-To: <CAGb2v65wmkHvibm8pLBkrD3h_TySoiV605=6VW+pJN3xgoEbKw@mail.gmail.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <5ed70f11299554e43f575aaf3b0bbe76991d8373.1507198895.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65wmkHvibm8pLBkrD3h_TySoiV605=6VW+pJN3xgoEbKw@mail.gmail.com>
Message-ID: <20171006084526.h2ty25pajknlchue@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 05, 2017 at 03:29:56PM +0000, Chen-Yu Tsai wrote:
> > @@ -531,83 +531,83 @@
> >                                 bias-pull-up;
> >                         };
> >
> > -                       ps20_pins_a: ps20 at 0 {
> > -                               pins = "PI20", "PI21";
> > +                       ps2_ph_pins: ps2-ph-pins {
> > +                               pins = "PH12", "PH13";
> >                                 function = "ps2";
> >                         };
> >
> > -                       ps21_pins_a: ps21 at 0 {
> > -                               pins = "PH12", "PH13";
> > +                       ps2_pi_pins: ps2-pi-pins {
> > +                               pins = "PI20", "PI21";
> >                                 function = "ps2";
> >                         };
> 
> This part is slightly incorrect. The PS/2 block has 2 inputs.
> The first channel, or ps2-0, has only one muxing option, on
> pins PI20 and PI21. The second channel has two options, either
> PH12 + PH13 or PI14 + PI15. The names should encode which channel
> the muxing option is for.

Would ps2_ch0_pins and ps2_ch1_pi_pins work for you then?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171006/2c7b2e2f/attachment.sig>

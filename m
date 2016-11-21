From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Nov 2016 23:04:14 +0100
Subject: [PATCH 9/10] ARM: sun5i: Convert to CCU
In-Reply-To: <CAGb2v64vOePTQ0a7cmSmimVrkYOxxRwRZnGbsC2ZQ4Su59oJaQ@mail.gmail.com>
References: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
 <4046893c1810045bac3eeb1ea3a35c5771d250e0.1478625788.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64vOePTQ0a7cmSmimVrkYOxxRwRZnGbsC2ZQ4Su59oJaQ@mail.gmail.com>
Message-ID: <20161121220414.bqsdjtpsjsq5tefs@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 11:01:27PM +0800, Chen-Yu Tsai wrote:
> >                         compatible = "allwinner,sun5i-a13-tcon";
> >                         reg = <0x01c0c000 0x1000>;
> >                         interrupts = <44>;
> > -                       resets = <&tcon_ch0_clk 1>;
> > +                       resets = <&ccu RST_LCD>;
> >                         reset-names = "lcd";
> > -                       clocks = <&ahb_gates 36>,
> > -                                <&tcon_ch0_clk>,
> > -                                <&tcon_ch1_clk>;
> > +                       clocks = <&ccu CLK_AHB_LCD>,
> > +                                <&ccu CLK_TCON_CH0>,
> > +                                <&ccu CLK_TCON_CH1>;
> 
> Just curious, is CLK_TCON_CH1_SCLK ever used?

Yes, this is an intermediate clock for the channel 1 clock.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/1222cbd5/attachment.sig>

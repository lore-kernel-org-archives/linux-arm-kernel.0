From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 21:31:20 +0100
Subject: [PATCH v2 10/26] ARM: sun5i: a13: Add display and TCON clocks
In-Reply-To: <CAGb2v67fqMUQsG-+zVxfgE3UzY7uyomBkwxgNHeXbqA1pwM8pA@mail.gmail.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-11-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67fqMUQsG-+zVxfgE3UzY7uyomBkwxgNHeXbqA1pwM8pA@mail.gmail.com>
Message-ID: <20160203203120.GF3327@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 17, 2016 at 01:06:07AM +0800, Chen-Yu Tsai wrote:
> > +                       compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
> > +                       reg = <0x01c20118 0x4>;
> > +                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> > +                       clock-output-names = "tcon-ch0-sclk";
> > +               };
> > +
> > +               tcon_ch1_clk: clk at 01c2012c {
> > +                       #clock-cells = <0>;
> > +                       compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
> > +                       reg = <0x01c2012c 0x4>;
> > +                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> > +                       clock-output-names = "tcon-ch1-sclk";
> > +               };
> 
> I suggest moving these to sun5i.dtsi, as they are shared amongst them.

Eventually, yes, but I don't have an a10s board handy, and I couldn't
test the clocks that needs to be taken by simplefb.

Once properly tested, they can definitely be moved to sun5i.dtsi.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/73dab241/attachment.sig>

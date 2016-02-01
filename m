From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Feb 2016 20:46:26 +0100
Subject: [PATCH v3 2/2] clk: sunxi: Refactor A31 PLL6 so that it can be
 reused
In-Reply-To: <CAGb2v67v6-BCPp2u7vieCGnCAsHFv4XjnRXvfT1vZNHc_Ok0UA@mail.gmail.com>
References: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454008958-12655-2-git-send-email-maxime.ripard@free-electrons.com>
 <56AB38C6.2010909@gmail.com>
 <CAGb2v67v6-BCPp2u7vieCGnCAsHFv4XjnRXvfT1vZNHc_Ok0UA@mail.gmail.com>
Message-ID: <20160201194626.GH4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 06:14:48PM +0800, Chen-Yu Tsai wrote:
> >> @@ -173,7 +173,7 @@
> >>                       #clock-cells = <0>;
> >>                       compatible = "allwinner,sun8i-h3-ahb2-clk";
> >>                       reg = <0x01c2005c 0x4>;
> >> -                     clocks = <&ahb1>, <&pll6d2>;
> >> +                     clocks = <&ahb1>, <&pll6>;
> >
> > According to the datasheet AHB2 really has PLL6 / 2 as parent, not PLL6
> > directly.
> 
> Thanks for the save. So we should keep pll6d2_clk.

Indeed thanks for the review. Will fix for v4.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/48505a6b/attachment.sig>

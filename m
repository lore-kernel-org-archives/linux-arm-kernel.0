From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 9 May 2015 13:29:36 +0200
Subject: [PATCH 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <5549EA63.5060602@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-3-git-send-email-jenskuske@gmail.com>
 <CAGb2v67dHFTttPhddOo+a2Rh0jaCxHqRw=Eo3jkNnFGCOfawRQ@mail.gmail.com>
 <5549EA63.5060602@gmail.com>
Message-ID: <20150509112936.GU11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 12:18:11PM +0200, Jens Kuske wrote:
> >>  /**
> >>   * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
> >>   *
> >> @@ -1252,6 +1288,7 @@ static const struct of_device_id clk_factors_match[] __initconst = {
> >>         {.compatible = "allwinner,sun5i-a13-ahb-clk", .data = &sun5i_a13_ahb_data,},
> >>         {.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
> >>         {.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
> >> +       {.compatible = "allwinner,sun8i-h3-pll8-clk", .data = &sun8i_h3_pll8_data,},
> > 
> > Matching comment above, no need to add a new compatible for something that's
> > the same.
> 
> PLL8 doesn't have a x2 output according to User Manual, but I did it
> wrong anyway, see first comment.

Don't worry too much about that output.

It's not really an output, it's a pre-multiplier on a single
child. We're discussing with Chen-Yu about refactoring this anyway, so
it will probably go away in a near future.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150509/ef264412/attachment-0001.sig>

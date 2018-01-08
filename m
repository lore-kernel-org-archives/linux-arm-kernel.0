From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 08 Jan 2018 10:10:39 +0100
Subject: [PATCH 2/5] clk: lpc32xx: read-only divider can propagate rate
 change
In-Reply-To: <54782a8f-9735-a574-d8e1-7ff3e9173229@mleia.com>
References: <20180105170959.17266-1-jbrunet@baylibre.com>
 <20180105170959.17266-3-jbrunet@baylibre.com>
 <5a256cde-8e59-4921-f6e2-fecd3d1c3377@mleia.com>
 <1515181225.5048.52.camel@baylibre.com>
 <54782a8f-9735-a574-d8e1-7ff3e9173229@mleia.com>
Message-ID: <1515402639.5048.82.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-01-06 at 16:04 +0200, Vladimir Zapolskiy wrote:
> > I added the fix to LPC32xx because it looks like the generic divider (a lot) and
> 
> right, the relevant divider operations were copied, however the difference
> is important, unfortunately there is no simple option to get rid of regmap,
> because System Control Block registers are shared with a number of other
> device drivers.

I have the same issue ;)

> 
> > appears to support CLK_DIVIDER_READ_ONLY. If it does not, could you please kill
> > the related code ?
> 
> The driver supports CLK_DIVIDER_READ_ONLY clocks, and it should not be
> changed, but all such clocks don't have children with CLK_SET_RATE_PARENT
> property, which invalidates your fix for LPC32xx. Please let me know,
> if I missed something.

You did not miss anything. I understand your choice.
I just have different approach and usually prefer to avoid these particularity
which may catch you later on. 

At least, the fact that propagation would stop with CLK_DIVIDER_READ_ONLY on
LPC32xx, even with CLK_SET_RATE_PARENT, is now known.

Adding a comment in the code to make this explicit would be nice though.

Regards
Jerome

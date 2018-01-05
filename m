From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 05 Jan 2018 20:40:25 +0100
Subject: [PATCH 2/5] clk: lpc32xx: read-only divider can propagate rate
 change
In-Reply-To: <5a256cde-8e59-4921-f6e2-fecd3d1c3377@mleia.com>
References: <20180105170959.17266-1-jbrunet@baylibre.com>
 <20180105170959.17266-3-jbrunet@baylibre.com>
 <5a256cde-8e59-4921-f6e2-fecd3d1c3377@mleia.com>
Message-ID: <1515181225.5048.52.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-01-05 at 20:12 +0200, Vladimir Zapolskiy wrote:
> Hi Jerome,
> 
> On 01/05/2018 07:09 PM, Jerome Brunet wrote:
> > When a divider clock has CLK_DIVIDER_READ_ONLY set, it means that the
> > register shall be left un-touched, but it does not mean the clock
> > should stop rate propagation if CLK_SET_RATE_PARENT is set
> > 
> 
> okay, the statement sounds correct, but there is no such clocks on LPC32xx,
> thus I hardly can confirm that adding dead/inapplicable code is a fix.
> 
> > This properly handled in qcom clk-regmap-divider but it was not in the
> > lpc32xx divider
> > 
> > Fixes: f7c82a60ba26 ("clk: lpc32xx: add common clock framework driver")
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> I would suggest to drop two LPC32xx clock driver changes from the series.

Hi Vladimir,

This is fine by me. Whether LPC32xx supports CLK_DIVIDER_READ_ONLY is up to you,
but you should be consistent about it.

I added the fix to LPC32xx because it looks like the generic divider (a lot) and
appears to support CLK_DIVIDER_READ_ONLY. If it does not, could you please kill
the related code ?

Regards
Jerome

> 
> --
> With best wishes,
> Vladimir

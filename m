From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 5 Jan 2018 20:12:45 +0200
Subject: [PATCH 2/5] clk: lpc32xx: read-only divider can propagate rate
 change
In-Reply-To: <20180105170959.17266-3-jbrunet@baylibre.com>
References: <20180105170959.17266-1-jbrunet@baylibre.com>
 <20180105170959.17266-3-jbrunet@baylibre.com>
Message-ID: <5a256cde-8e59-4921-f6e2-fecd3d1c3377@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On 01/05/2018 07:09 PM, Jerome Brunet wrote:
> When a divider clock has CLK_DIVIDER_READ_ONLY set, it means that the
> register shall be left un-touched, but it does not mean the clock
> should stop rate propagation if CLK_SET_RATE_PARENT is set
> 

okay, the statement sounds correct, but there is no such clocks on LPC32xx,
thus I hardly can confirm that adding dead/inapplicable code is a fix.

> This properly handled in qcom clk-regmap-divider but it was not in the
> lpc32xx divider
> 
> Fixes: f7c82a60ba26 ("clk: lpc32xx: add common clock framework driver")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

I would suggest to drop two LPC32xx clock driver changes from the series.

--
With best wishes,
Vladimir

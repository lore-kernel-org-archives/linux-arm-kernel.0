From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 28 Nov 2013 09:34:10 +0100
Subject: [PATCH v5 06/17] clk: at91: add PMC pll clocks
In-Reply-To: <20131127214843.16819.59481@quantum>
References: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
 <1384293439-4525-1-git-send-email-b.brezillon@overkiz.com>
 <20131127214843.16819.59481@quantum>
Message-ID: <52970002.3020405@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 27/11/2013 22:48, Mike Turquette wrote:
> Quoting Boris BREZILLON (2013-11-12 13:57:19)
>> +static const struct clk_ops pll_ops = {
>> +       .prepare = clk_pll_prepare,
>> +       .is_prepared = clk_pll_is_ready,
>> +       .disable = clk_pll_disable,
>> +       .is_enabled = clk_pll_is_ready,
>> +       .recalc_rate = clk_pll_recalc_rate,
>> +       .round_rate = clk_pll_round_rate,
>> +       .set_rate = clk_pll_set_rate,
>> +};
> Hi Boris,
>
> It is a bit strange to see only a .prepare and .disable callback
> populated. What happens if a driver calls clk_disable and then
> clk_enable? You clock will still be disabled in hardware.

Oops, I haven't thought about that.
I did this because the clk_pll_disable does not sleep, but this is a big 
mistake :-(.

I'll fix this.

Thanks.

Best Regards,

Boris
> Regards,
> Mike

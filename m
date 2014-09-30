From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 30 Sep 2014 23:50:38 +0800
Subject: [PATCH v2 2/7] clk: sunxi: Implement A31 PLL6 as a divs clock for
 2x output
In-Reply-To: <20140930153957.GM4081@lukather>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
 <1411807795-6575-3-git-send-email-wens@csie.org>
 <20140930153957.GM4081@lukather>
Message-ID: <CAGb2v67PQBkHaXareOHM5s+HXfCtbaESYqBhXxUAY59LV4zTxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 30, 2014 at 11:39 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sat, Sep 27, 2014 at 04:49:50PM +0800, Chen-Yu Tsai wrote:
>> Some clock modules on the A31 use PLL6x2 as one of their inputs.
>> This patch changes the PLL6 implementation for A31 to a divs clock,
>> i.e. clock with multiple outputs that have different dividers.
>> The first output will be the normal PLL6 output, and the second
>> will be PLL6x2.
>>
>> This patch fixes the PLL6 N factor in the clock driver, and removes
>> any /2 dividers in the PLL6 factors clock part. The N factor counts
>> from 1 to 32, mapping to values 0 to 31, as shown in the A31 manual.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  Documentation/devicetree/bindings/clock/sunxi.txt |  5 ++--
>>  drivers/clk/sunxi/clk-sunxi.c                     | 28 +++++++++++++----------
>>  2 files changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
>> index d3a5c3c..0d84f4b 100644
>> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
>> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
>> @@ -59,8 +59,9 @@ Required properties for all clocks:
>>       multiplexed clocks, the list order must match the hardware
>>       programming order.
>>  - #clock-cells : from common clock binding; shall be set to 0 except for
>> -     "allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk" and
>> -     "allwinner,sun4i-pll6-clk" where it shall be set to 1
>> +     the following compatibles where it shall be set to 1:
>> +     "allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
>> +     "allwinner,sun4i-pll6-clk", "allwinner, sun6i-a31-pll6-clk"
>                                                ^ Drop this extra space
>
> And you're still not documenting what outputs you might have on pll6,
> and what the extra argument correspond to.

Sorry. Missed that part.

ChenYu

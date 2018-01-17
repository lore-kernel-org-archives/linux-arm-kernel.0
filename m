From: david@lechnology.com (David Lechner)
Date: Wed, 17 Jan 2018 11:55:54 -0600
Subject: [3/5] clk: divider: add divider_ro_round_rate helper
In-Reply-To: <1516211221.2608.140.camel@baylibre.com>
References: <20180105170959.17266-4-jbrunet@baylibre.com>
 <f32ed81b-685e-acf6-d2d9-ecd27fd9b8ba@lechnology.com>
 <1516211221.2608.140.camel@baylibre.com>
Message-ID: <d8b71ac7-5929-8450-e932-926e7fe1b629@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2018 11:47 AM, Jerome Brunet wrote:
> On Thu, 2018-01-11 at 17:08 -0600, David Lechner wrote:
>> On 01/05/2018 11:09 AM, Jerome Brunet wrote:
>>> Like divider_round_rate, a couple a of driver are doing more or less
>>> the same operation to round the rate of the divider when it is read-only.
>>>
>>> We can factor this code so let's provide an helper function for this
>>
>> Perhaps you could also make use of this new helper here (clk-divider.c):
>>
>> const struct clk_ops clk_divider_ro_ops = {
>> 	.recalc_rate = clk_divider_recalc_rate,
>> 	.round_rate = clk_divider_round_rate,
>> };
>> EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
> 
> The helper is used in this driver and ro_ops will use it.
> I don't get this comment, could you be more specific

I suppose I am trying to make things too complicated. Let's just forget
about this.

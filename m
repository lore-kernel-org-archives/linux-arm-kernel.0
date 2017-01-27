From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Jan 2017 11:30:05 +0800
Subject: [PATCH 1/2] clk: sunxi-ng: Call divider_round_rate if we only
 have a single parent
In-Reply-To: <20170127001250.GQ8801@codeaurora.org>
References: <53c56d23af099d8a41460d5ac59a2c792c8d050c.1485250845.git-series.maxime.ripard@free-electrons.com>
 <20170127001250.GQ8801@codeaurora.org>
Message-ID: <CAGb2v67pdKYW5jaa1jA5+QbEV50iPNt-9Z7MNE90P+vUYVocNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 8:12 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/24, Maxime Ripard wrote:
>> The divider_get_val function that is used in our determine_rate callback
>> doesn't try to change the parent rate at all, while clk_divider_bestdiv,
>> used in divider_round_rate, does.
>>
>> If we have a single parent, call divider_round_rate.

I guess my "clk: sunxi-ng: mux: Get closest parent rate possible with
CLK_SET_RATE_PARENT" patch somewhat takes care of the multi-parent
case? Still, the underlying clock type doesn't get to specify what
is considers to be the best parent rate.

>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

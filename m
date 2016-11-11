From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Nov 2016 16:45:49 +0800
Subject: [PATCH v2 3/3] pinctrl: sunxi: Make sunxi_pconf_group_set use
 sunxi_pconf_reg helper
In-Reply-To: <20161111083852.yacy33g6pag6ucon@lukather>
References: <20161111024455.16883-1-wens@csie.org>
 <20161111024455.16883-4-wens@csie.org>
 <20161111083852.yacy33g6pag6ucon@lukather>
Message-ID: <CAGb2v64=FrhdGyT1UybqRfLHXRb--LwFn31G7VdndBbhDGV4-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 4:38 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Nov 11, 2016 at 10:44:55AM +0800, Chen-Yu Tsai wrote:
>> The sunxi_pconf_reg helper introduced in the last patch gives us the
>> chance to rework sunxi_pconf_group_set to have it match the structure
>> of sunxi_pconf_(group_)get and make it easier to understand.
>>
>> For each config to set, it:
>>
>>     1. checks if the parameter is supported.
>>     2. checks if the argument is within limits.
>>     3. converts argument to the register value.
>>     4. writes to the register with spinlock held.
>>
>> As a result the function now blocks unsupported config parameters,
>> instead of silently ignoring them.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> But I think the config variable removal should be part of patch 2, as
> discussed there.

OK. I think that makes sense. Re-reading my patches, I can't figure out,
which patch I meant for it to go in. :(

I'll send out a v3.

ChenYu

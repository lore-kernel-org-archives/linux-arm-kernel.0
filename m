From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 7 May 2012 10:34:48 -0700
Subject: [PATCH 2/5] clk: prevent spurious parent rate propagation
In-Reply-To: <20120507075836.GE4141@pengutronix.de>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
 <1336367310-5140-3-git-send-email-mturquette@linaro.org>
 <20120507075836.GE4141@pengutronix.de>
Message-ID: <CAJOA=zMvskjUD+U9OTME0tYhudYywYHJPC9evBcwA7-AFhngEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 12:58 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Sun, May 06, 2012 at 10:08:27PM -0700, Mike Turquette wrote:
>> Patch 'clk: always pass parent_rate into .round_rate' made a subtle
>> change to the semantics of .round_rate. ?It is now expected for the
>> parent's rate to always be passed in, simplifying the implemenation of
>> various .round_rate callback definitions.
>>
>> However the patch also introduced a bug in clk_calc_new_rates whereby a
>> clock without the CLK_SET_RATE_PARENT flag set could still propagate a
>> rate change up to a parent clock if the the .round_rate callback
>> modified the &best_parent_rate value in any way.
>>
>> This patch fixes the issue at the framework level (in
>> clk_calc_new_rates) by specifically handling the case where the
>> CLK_SET_RATE_PARENT flag is not set.
>>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>> Reported-by: Sascha Hauer<s.hauer@pengutronix.de>
>
> I think a warning might be useful when a clk driver tries to change the
> parent rate even if it is not allowed to. This can be added in a later
> patch, so
>

A fine idea.

> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>

Thanks,
Mike

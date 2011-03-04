From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Mar 2011 11:10:03 +0100
Subject: [PATCHv4 0/4] ARM: Fixing udelay() for SMP and non-SMP systems
In-Reply-To: <1292883633-19553-1-git-send-email-sboyd@codeaurora.org>
References: <1292883633-19553-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <AANLkTi=KU_zUrBsp0a9iJyj6RmTgYqZcffQynTV-2tKW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/20 Stephen Boyd <sboyd@codeaurora.org>:

> These patches fix the udelay() issue pointed out on
> arm-lkml[1][2]. A quick recap: some SMP machines can scale
> their CPU frequencies independent of one another. loops_per_jiffy
> is calibrated globally and used in __const_udelay(). If one CPU
> is running faster than what the loops_per_jiffy is calculated
> (or scaled) for, udelay() will be incorrect and not wait long
> enough (or too long). A similar problem occurs if the cpu
> frequency is scaled during a udelay() call.

Hwt's happening to this patch set? We have applied it and
implemented a timer for the U8500.

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Mattias WALLIN can probably also provide a Tested-by:
from ST-Ericsson if it helps.

Generally I think this is good and important stuff that should
be merged, will you be submitting it to Russells patch tracker
or pull request for 2.6.39?

Yours,
Linus Walleij

From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 30 Jul 2015 22:34:15 +0800
Subject: [PATCH 7/7] clk: sunxi: Add a simple gates driver
In-Reply-To: <20150730101723.GL2564@lukather>
References: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
 <1437945270-32014-8-git-send-email-maxime.ripard@free-electrons.com>
 <20150727202648.GB14521@codeaurora.org>
 <CAGb2v6517qCXmNkYihnfBmc5fL7bqTDOQwedNYjq+p2Mg45+gQ@mail.gmail.com>
 <20150730101723.GL2564@lukather>
Message-ID: <CAGb2v64zHJsD-CwG4Z=UMuL7xqNdgWGjv-9T9OF6jKuz2WkXUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 6:17 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Jul 30, 2015 at 03:55:17PM +0800, Chen-Yu Tsai wrote:
>> On Tue, Jul 28, 2015 at 4:26 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 07/26, Maxime Ripard wrote:
>> >> diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
>> >> new file mode 100644
>> >> index 000000000000..1a3963a8a686
>> >> --- /dev/null
>> >> +++ b/drivers/clk/sunxi/clk-simple-gates.c
>> >> @@ -0,0 +1,159 @@
>> >> +/*
>> >> + * Copyright 2015 Maxime Ripard
>> >> + *
>> >> + * Maxime Ripard <maxime.ripard@free-electrons.com>
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify
>> >> + * it under the terms of the GNU General Public License as published by
>> >> + * the Free Software Foundation; either version 2 of the License, or
>> >> + * (at your option) any later version.
>> >> + *
>> >> + * This program is distributed in the hope that it will be useful,
>> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >> + * GNU General Public License for more details.
>> >> + */
>> >> +
>>
>> I'm guessing the following were copied from clk-sunxi.c.
>>
>> >> +#include <linux/clk-provider.h>
>> >> +#include <linux/clkdev.h>
>> >
>> > Is this used?
>>
>> clk_register_clkdev() is not used in this file, so not needed.
>>
>> >> +#include <linux/of.h>
>> >> +#include <linux/of_address.h>
>> >> +#include <linux/reset-controller.h>
>> >
>> > Is this used?
>>
>> A remnant of the USB clocks, which has been moved to clk-usb.c.
>>
>> Not needed here nor in clk-sunxi.c.
>>
>> >> +#include <linux/spinlock.h>
>> >> +#include <linux/log2.h>
>> >
>> > Is this used?
>>
>> This is only used for clock factor calculation. Not applicable in
>> clk-simple-gates.c, so no.
>
> You're right, we don't need any of these...
>
>> >> +static DEFINE_SPINLOCK(gates_lock);
>> >> +
>> > [...]
>> >> +
>> >> +static const int sun4i_a10_ahb_critical_clocks[] __initdata = {
>> >
>> > Shouldn't it be __initconst ?
>>
>> Not sure why our critical clocks lists are __initdata...
>
> Why shouldn't it be?
>
> CLK_OF_DECLARE callbacks only run at of_clk_init time, which is way
> before the init memory is discarded.

Sorry, I meant why __initdata and not __initconst.

ChenYu

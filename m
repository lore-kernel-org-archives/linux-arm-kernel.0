From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 13 Mar 2012 15:41:21 -0700
Subject: [PATCH v6 2/3] clk: introduce the common clock framework
In-Reply-To: <4F5FC090.90005@gmail.com>
References: <1331366064-1273-1-git-send-email-mturquette@linaro.org>
 <1331366064-1273-3-git-send-email-mturquette@linaro.org>
 <4F5FC090.90005@gmail.com>
Message-ID: <CAJOA=zMtaiHWmUJJO7eWEmGQkNmkzHnr0B4zneDrEEirFn3hAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 2:48 PM, Rob Herring <robherring2@gmail.com> wrote:
> Mike,
>
> On 03/10/2012 01:54 AM, Mike Turquette wrote:
>> The common clock framework defines a common struct clk useful across
>> most platforms as well as an implementation of the clk api that drivers
>> can use safely for managing clocks.
>>
>> The net result is consolidation of many different struct clk definitions
>> and platform-specific clock framework implementations.
>>
>> This patch introduces the common struct clk, struct clk_ops and an
>> implementation of the well-known clock api in include/clk/clk.h.
>> Platforms may define their own hardware-specific clock structure and
>> their own clock operation callbacks, so long as it wraps an instance of
>> struct clk_hw.
>>
>> See Documentation/clk.txt for more details.
>>
>> This patch is based on the work of Jeremy Kerr, which in turn was based
>> on the work of Ben Herrenschmidt.
>>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Arnd Bergman <arnd.bergmann@linaro.org>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Shawn Guo <shawn.guo@freescale.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Richard Zhao <richard.zhao@linaro.org>
>> Cc: Saravana Kannan <skannan@codeaurora.org>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Linus Walleij <linus.walleij@stericsson.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Amit Kucheria <amit.kucheria@linaro.org>
>> Cc: Deepak Saxena <dsaxena@linaro.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>
> snip
>
>> +
>> + ? ? /*
>> + ? ? ?* walk the list of orphan clocks and reparent any that are children of
>> + ? ? ?* this clock
>> + ? ? ?*/
>> + ? ? hlist_for_each_entry(orphan, tmp, &clk_orphan_list, child_node)
>
> In __clk_init, this needs to be hlist_for_each_entry_safe as entries can
> be removed.

Thanks for the catch Rob.  I'll take this in.

Regards,
Mike

>
> Rob
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev

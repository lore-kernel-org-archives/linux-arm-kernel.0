From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 05 Jun 2012 10:05:34 +0530
Subject: [RFC 13/24] ARM: omap4: clk: Add 44xx data using common struct clk
In-Reply-To: <4FCD3357.5090409@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
 <1338552485-31325-14-git-send-email-rnayak@ti.com> <4FCD3357.5090409@ti.com>
Message-ID: <4FCD8C96.6010405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

>> +
>> +static const struct clksel_rate div_1_0_rates[] = {
>> +	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_1_rates[] = {
>> +	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_2_rates[] = {
>> +	{ .div = 1, .val = 2, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_3_rates[] = {
>> +	{ .div = 1, .val = 3, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_4_rates[] = {
>> +	{ .div = 1, .val = 4, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_5_rates[] = {
>> +	{ .div = 1, .val = 5, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>
> The above clksel_rate structures could be used by OMAP2/3 devices too
> (assuming that the flags is set for OMAP2/3/4 devices). Any reason why
> these cannot be placed in a global header? It could remove quite a bit
> of repetitive code. I know these are auto-generated, but maybe we should
> have the auto-generator spit out the clksel_rate structs to another file
> (ie. a global header).

Well, I did not try doing any further optimizations and tried keeping
the same layout of data files so its easier to review, given the changes
already due to using common struct clk movement. We can certainly do
further optimizations/cleanups on top of this series.
I would really want to keep cleanups/optimizations separate (unless
they are cleanups/optimizations done as part of moving to common clk
itself) from common clk movement series. There are other optimizations
too like getting rid of some unwanted leaf clocks for omap4, moving
handling of clkdms for leaf clks into hwmod for OMAP2/3. But all those
are happening separately and can happen in the existing code without
having it being moved to common clk.

>
> By the way, div_1_3/4/5_rates don't appear to be used in this file.

ok, thanks, will have a look and get rid of it if its really unused.

regards,
Rajendra
>
> Cheers
> Jon

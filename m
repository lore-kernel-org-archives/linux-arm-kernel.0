From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 3 Oct 2011 15:15:33 -0700
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <4E8A30F2.7010502@gmail.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<4E8A30F2.7010502@gmail.com>
Message-ID: <CAJOA=zPZYE7R3y_Ybrq=PMAouL4cnOHkjsg+pR2R8yLzZ9YMaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2011 at 3:02 PM, Rob Herring <robherring2@gmail.com> wrote:
> Mike,
>
> On 09/22/2011 05:26 PM, Mike Turquette wrote:
>
>> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
>> index 6db161f..e2a9719 100644
>> --- a/drivers/clk/clkdev.c
>> +++ b/drivers/clk/clkdev.c
>> @@ -23,6 +23,13 @@
>> ?static LIST_HEAD(clocks);
>> ?static DEFINE_MUTEX(clocks_mutex);
>>
>> +/* For USE_COMMON_STRUCT_CLK, these are provided in clk.c, but not exported
>> + * through other headers; we don't want them used anywhere but here. */
>> +#ifdef CONFIG_USE_COMMON_STRUCT_CLK
>> +extern int __clk_get(struct clk *clk);
>> +extern void __clk_put(struct clk *clk);
>> +#endif
>> +
>
> This is dead code left from prior versions.

Indeed it is.  Will pull it out for V3.

Thanks,
Mike

> Rob
>

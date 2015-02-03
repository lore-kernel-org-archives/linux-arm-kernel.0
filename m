From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 3 Feb 2015 19:43:59 +0200
Subject: [PATCH v13 5/6] clkdev: Export clk_register_clkdev
In-Reply-To: <CAHp75VfN1-dwN5nAp=VLkm6Q-9UqhGHsB2ZFhq+b238mgjVoMQ@mail.gmail.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-6-git-send-email-tomeu.vizoso@collabora.com>
 <CAHp75VfN1-dwN5nAp=VLkm6Q-9UqhGHsB2ZFhq+b238mgjVoMQ@mail.gmail.com>
Message-ID: <CAHp75VeUgYup++JUf4kVNBK6HNppcF3DcKtaWjUF4o+ZbOBUpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 3, 2015 at 7:35 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jan 23, 2015 at 1:03 PM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> So it can be used from modules such as clk-test.ko.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>
> Sorry for late answer, but this is useless.
>
> We have to provide the way how to get the allocated clk_lookup.
> Otherwise you have no way but memory leak at the ->remove() stage.
>
> (By the way I used to have the exact patch locally, that's why
> discovered the change in upsteam)
>

Will send a patch soon to fix this.

>> ---
>>  drivers/clk/clkdev.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
>> index 901d242..29a1ab7 100644
>> --- a/drivers/clk/clkdev.c
>> +++ b/drivers/clk/clkdev.c
>> @@ -377,6 +377,7 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
>>
>>         return 0;
>>  }
>> +EXPORT_SYMBOL(clk_register_clkdev);
>>
>>  /**
>>   * clk_register_clkdevs - register a set of clk_lookup for a struct clk
>> --
>> 1.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko

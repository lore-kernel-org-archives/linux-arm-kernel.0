From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 31 Jan 2017 21:32:36 +0100
Subject: [PATCH 1/3] mmc: meson-gx: fix setting f_min
In-Reply-To: <CAPDyKFrhTm7A_tq_W3yWoPv95exZ-LTtEhiQhw134AfGZuRY+Q@mail.gmail.com>
References: <e26a74f8-9819-6940-4c90-225377cc0a3e@gmail.com>
 <CAPDyKFrhTm7A_tq_W3yWoPv95exZ-LTtEhiQhw134AfGZuRY+Q@mail.gmail.com>
Message-ID: <d974bc57-1959-e16e-eb89-0e1dc37d8f15@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.01.2017 um 12:55 schrieb Ulf Hansson:
> On 26 January 2017 at 22:41, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> Currently f_min is set to 4 MHz whilst the comment states 400 MHz.
>> I think the itention is to set f_min to 400 kHz.
>> Change value and comment accordingly.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Heiner, could you please collect the mmc meson changes that you
> recently have submitted in one series and re-post to linux-mmc. I can
> pick them up from there.
> 
Sure. Apart from the ones you've reviewed already I have few more.
I'll add them to the patch set.

Regards, Heiner

> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index bf19d03c..cf071756 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -268,7 +268,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>         if (f_min != UINT_MAX)
>>                 f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
>>         else
>> -               f_min = 4000000;  /* default min: 400 MHz */
>> +               f_min = 400000;  /* default min: 400 kHz */
>>         host->mmc->f_min = f_min;
>>
>>         /* create the mux */
>> --
>> 2.11.0
>>
> 

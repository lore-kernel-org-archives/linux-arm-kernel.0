From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 25 Aug 2015 14:06:31 +0200
Subject: [linux-sunxi] [PATCH v3 1/3] mmc: sunxi: fix timeout in
 sunxi_mmc_oclk_onoff
In-Reply-To: <55CB5CE6.1000303@redhat.com>
References: <cover.1439381423.git.hramrach@gmail.com>
 <7f9c6f99b31702c02436ef3356b3ebffa4754260.1439381423.git.hramrach@gmail.com>
 <bdcb7ce26f359b7fedbd8559eb275c324bfb52bb.1439386047.git.hramrach@gmail.com>
 <55CB5CE6.1000303@redhat.com>
Message-ID: <CAPDyKFp67DTNXYiphqPKsKL9ZtGO28x_UZa-d-KifD-7EXGzhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2015 at 16:49, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 08/12/2015 03:29 PM, Michal Suchanek wrote:
>>
>> The 250ms timeout is too short.
>>
>> On my system enabling the oclk takes under 50ms and disabling slightly
>> over 100ms when idle. Under load disabling the clock can take over
>> 350ms.
>>
>> This does not make mmc clock gating look like good option to have on
>> sunxi but the system should not crash with mmc clock gating enabled
>> nonetheless.
>>
>> This patch sets the timeout to 750ms.
>>
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>>
>> ---
>> v3
>>   - remove debug message
>
>
> Thanks, this one looks good to me:
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>
> Ulf, can you apply this one please?
>
> Thanks & Regards,
>
> Hans
>

Thanks, applied for next!

Kind regards
Uffe

>
>
>> v2
>>   - fix formatting
>> ---
>>   drivers/mmc/host/sunxi-mmc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 4d3e1ff..a7b7a67 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -595,7 +595,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int
>> irq, void *dev_id)
>>
>>   static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32
>> oclk_en)
>>   {
>> -       unsigned long expire = jiffies + msecs_to_jiffies(250);
>> +       unsigned long expire = jiffies + msecs_to_jiffies(750);
>>         u32 rval;
>>
>>         rval = mmc_readl(host, REG_CLKCR);
>>
>

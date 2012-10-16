From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 16 Oct 2012 16:59:42 +0800
Subject: [PATCH 2/2] ASoC: atmel-ssc: use module_platform_driver macro
In-Reply-To: <20121016084947.GD12801@game.jcrosoft.org>
References: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
 <1350359819-2461-2-git-send-email-voice.shen@atmel.com>
 <507D15C2.7000606@atmel.com> <20121016084947.GD12801@game.jcrosoft.org>
Message-ID: <507D21FE.1050402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2012 16:49, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:07 Tue 16 Oct     , Nicolas Ferre wrote:
>> On 10/16/2012 05:56 AM, Bo Shen :
>>> This patch removes some code duplication by using module_platform_driver
>>>
>>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>>
>> Very good simplification but...
>>
>>> ---
>>>   drivers/misc/atmel-ssc.c |   18 ++++--------------
>>>   1 file changed, 4 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
>>> index 23dcb76..ac00f83 100644
>>> --- a/drivers/misc/atmel-ssc.c
>>> +++ b/drivers/misc/atmel-ssc.c
>>> @@ -68,7 +68,7 @@ void ssc_free(struct ssc_device *ssc)
>>>   }
>>>   EXPORT_SYMBOL(ssc_free);
>>>
>>> -static int __init ssc_probe(struct platform_device *pdev)
>>> +static int ssc_probe(struct platform_device *pdev)
>>
>> Here you remove the __init altogether, maybe converting to __devinit is
>> the proper replacement for this? I do not know myself but if anybody knows?
> yes __devinit is mandatory

I will add a small patch to fix this.

Thanks.

BRs,
Bo Shen

>
> Best Regards,
> J.
>

From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 2 May 2016 15:58:56 +0100
Subject: [PATCH v2] nvmem/mxs-ocotp: fix buffer overflow in read
In-Reply-To: <5727694B.80708@i2se.com>
References: <1f26dfe5-c75f-39df-e21e-77aeea408258@meduna.org>
 <57275C69.9060902@i2se.com> <20160502144458.GA15555@kroah.com>
 <5727694B.80708@i2se.com>
Message-ID: <57276B30.8080909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,


On 02/05/16 15:50, Stefan Wahren wrote:
> Hi Stano,
>
> Am 02.05.2016 um 16:44 schrieb Greg Kroah-Hartman:
>> On Mon, May 02, 2016 at 03:55:53PM +0200, Stefan Wahren wrote:
>>> Hi Srinivas,
>>> hi Greg,
>>>
>>> Am 27.04.2016 um 14:39 schrieb Stanislav Meduna:
>>>> This patch fixes the issue where the mxs_ocotp_read is reading
>>>> the ocotp in reg_size steps but decrements the remaining size
>>>> by 1. The number of iterations is thus four times higher,
>>>> overwriting the area behind the output buffer.
>>>>
>>>> Fixes: c01e9a11ab6f ("nvmem: add driver for ocotp in i.MX23 and i.MX28")
>>>> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>> Signed-off-by: Stanislav Meduna <stano@meduna.org>
>>> any change to get this critical fix into 4.6?
>> This is the first I've seen this patch :(
>
> sorry for this.
>
>>
>> Can you resend it in a format I can apply it in?
>
> Could you please resend V2 to Greg?

I will re-send this patch to Greg in next few mins..

thanks,
srini

>
> Thanks
> Stefan
>
>>
>> thanks,
>>
>> greg k-h
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

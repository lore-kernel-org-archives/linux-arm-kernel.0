From: s-anna@ti.com (Anna, Suman)
Date: Wed, 15 Jan 2014 17:46:50 -0600
Subject: [PATCHv4 6/7] hwspinlock/omap: enable module before reading
 SYSSTATUS register
In-Reply-To: <52D56C3A.7000704@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-7-git-send-email-s-anna@ti.com>
 <20140114131052.GA10818@saruman.home> <20140114140440.GA15785@saruman.home>
 <52D56C3A.7000704@ti.com>
Message-ID: <52D71DEA.6020602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

 >
> On 01/14/2014 08:04 AM, Felipe Balbi wrote:
>> Hi again,
>>
>> On Tue, Jan 14, 2014 at 07:10:52AM -0600, Felipe Balbi wrote:
>>>> diff --git a/drivers/hwspinlock/omap_hwspinlock.c
>>>> b/drivers/hwspinlock/omap_hwspinlock.c
>>>> index 9f56fb2..194886e 100644
>>>> --- a/drivers/hwspinlock/omap_hwspinlock.c
>>>> +++ b/drivers/hwspinlock/omap_hwspinlock.c
>>>> @@ -101,10 +101,23 @@ static int omap_hwspinlock_probe(struct
>>>> platform_device *pdev)
>>>>       if (!io_base)
>>>>           return -ENOMEM;
>>>>
>>>> +    /*
>>>> +     * make sure the module is enabled and clocked before reading
>>>> +     * the module SYSSTATUS register
>>>> +     */
>>>> +    pm_runtime_enable(&pdev->dev);
>>>> +    pm_runtime_get_sync(&pdev->dev);
>>
>> another thing, you need to check return of pm_runtime_get_sync()
>
> OK, let me check this and your other comment, and the fix is probably a
> separate patch.
>

I realized the changes relevant to your comments were introduced in this 
patch, so just refreshed the patch with fixes instead of doing a 
separate patch. I didn't do a v5 just for these change, and will do so 
if there are more comments on the DT adaptation.

regards
Suman

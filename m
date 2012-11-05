From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Nov 2012 20:30:37 +0530
Subject: [PATCH 02/15] ARM: OMAP2+: mailbox: Add support for AM33XX
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFFD1A@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-3-git-send-email-vaibhav.bedia@ti.com>
 <509541FD.4040307@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFFD1A@DBDE01.ent.ti.com>
Message-ID: <5097D495.6000704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 November 2012 08:56 PM, Bedia, Vaibhav wrote:
> On Sat, Nov 03, 2012 at 21:40:37, Shilimkar, Santosh wrote:
> [...]
>
>>> +#if defined(CONFIG_SOC_AM33XX)
>>> +	else if (soc_is_am33xx()) {
>>> +		list = am33xx_mboxes;
>>> +
>>> +		list[0]->irq = platform_get_irq(pdev, 0);
>>> +	}
>>> +#endif
>> #ifdef in middle of the function looks really ugly. But I can't complain
>> just for your patch because looks like rest of the mailbox code is
>> flooded with #ifdeffery.
>>
>> Mailbox needs cleanup. and probably can be moved out of
>> arch/arm/*omap*/ to some driver directory.
>>
>
> Tony pointed out that the movement to drivers directory
> is underway [1]. Getting rid of the #ifdeffery could be next.
>
Thanks for the pointer. Nice to see mailbox is getting moved
to drivers directory.

Regards
Santosh

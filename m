From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Nov 2013 18:37:07 +0530
Subject: [PATCH] ARM: davinci: aemif: get rid of davinci-nand driver
 dependency on aemif
In-Reply-To: <5295D102.2010101@ti.com>
References: <5291CB01.1010506@ti.com>
 <1385409654-19006-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5295AECB.7040503@ti.com> <5295D102.2010101@ti.com>
Message-ID: <5295EE7B.6030504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 November 2013 04:31 PM, ivan.khoronzhuk wrote:
>>> @@ -192,9 +193,15 @@ static __init void davinci_ntosd2_init(void)
>>>           davinci_cfg_reg(DM644X_ATAEN_DISABLE);
>>>
>>>           /* only one device will be jumpered and detected */
>>> -        if (HAS_NAND)
>>> +        if (HAS_NAND) {
>>>               platform_device_register(
>>>                       &davinci_ntosd2_nandflash_device);
>>> +
>>> +            if (davinci_aemif_setup(
>>> +                &davinci_ntosd2_nandflash_device))
>>> +                pr_warn("%s: Cannot configure AEMIF.\n",
>>> +                    __func__);
>>
>> This is looking really ugly. Can you shorten
>> davinci_ntosd2_nandflash_device to just "ntosd2_nandflash" or similar?
> 
> The rename is not related to the patch, so I won't do this.

The reason I asked you to rename is not because I want to push some
random clean-up into this patch. You had to introduce a line so broken
that its almost unreadable. I offered the suggestion as a way to improve
the readability of the code you are introducing in *this* patch.

Thanks,
Sekhar

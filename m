From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Wed, 4 Apr 2012 23:15:19 +0530
Subject: [PATCHv5 16/18] I2C: OMAP: fix missing handling of errata
 I2C_OMAP3_1P153
In-Reply-To: <4F7C7780.7040807@ti.com>
References: <1333468957-5999-1-git-send-email-shubhrajyoti@ti.com>
 <1333468957-5999-17-git-send-email-shubhrajyoti@ti.com>
 <4F7C7780.7040807@ti.com>
Message-ID: <CAM=Q2cu8k8n2w8_=8VCFcFTTgywqc_Vk_eM_DDTap3YeYyAH2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,


>> + ? ? ? if (dev->flags& ?OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>>
>> + ? ? ? ? ? ? ? dev->errata |= I2C_OMAP_ERRATA_I207;
>> +
>> ? ? ? ?if (dev->rev<= OMAP_I2C_REV_ON_3430_3530)
>> ? ? ? ? ? ? ? ?dev->errata |= I2C_OMAP3_1P153;
>
>
> The errata ID is not correct. I believe that 1P153 is referring to the
> section number in the errata doc and not the errata ID. The errata ID should
> be i451 in the latest OMAP34xx and OMAP36xx docs.
>
> Please can you update this? The section number changed in the latest errata
> docs and it took me a minute to find this.

Do you mind if that is a separate patch?

>
> Cheers
> Jon
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html

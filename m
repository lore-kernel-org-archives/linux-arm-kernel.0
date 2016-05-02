From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 2 May 2016 15:12:48 -0400
Subject: [PATCH] s5p-mfc: Don't try to put pm->clock if lookup failed
In-Reply-To: <2610031.B6nN8fjXyO@wuerfel>
References: <1462210075-5320-1-git-send-email-javier@osg.samsung.com>
 <2610031.B6nN8fjXyO@wuerfel>
Message-ID: <090a74db-f168-ed0a-f0f5-5ecd10ec80fc@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Thanks for your feedback.

On 05/02/2016 02:41 PM, Arnd Bergmann wrote:
> On Monday 02 May 2016 13:27:54 Javier Martinez Canillas wrote:
>> Failing to get the struct s5p_mfc_pm .clock is a non-fatal error so the
>> clock field can have a errno pointer value. But s5p_mfc_final_pm() only
>> checks if .clock is not NULL before attempting to unprepare and put it.
>>
>> This leads to the following warning in clk_put() due s5p_mfc_final_pm():
>>
> 
> Better assign the pointer to NULL in case of a non-fatal error
> return code. That way, the reader doesn't have to wonder why you
> have the IS_ERR_OR_NULL() check here.
>

Ok, I'll re-spin the patch doing that instead.
 
> 	Arnd
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

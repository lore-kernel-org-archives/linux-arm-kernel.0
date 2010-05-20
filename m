From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 20 May 2010 10:36:59 +0800
Subject: [patch] nuc900fb: release correct mem region
In-Reply-To: <20100519194854.GB22515@bicker>
References: <20100325105408.GD5069@bicker>
	<20100519194854.GB22515@bicker>
Message-ID: <AANLkTimDYkjTEVMFl8Vrbwblg46-ErGEaUV3M9-DWbCu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

Qiang brother have a busy doing business, so I can maintain the
nuc900fb driver instead.
It looks good to me.

Andrew , Could you help merge this patch? thanks a lot!

Acked-by: Wan ZongShun<mcuos.com@gmail.com>


2010/5/20 Dan Carpenter <error27@gmail.com>:
> Ping. ?Any feedback on this patch?
>
> regards,
> dan carpenter
>
> On Thu, Mar 25, 2010 at 01:54:08PM +0300, Dan Carpenter wrote:
>> We should be releasing "res->start" here.
>>
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
>> ---
>> BTW. ?Congratulations on being an official driver maintainer now. ?:) ?Can
>> you add yourself to the MAINTAINERS file?
>>
>> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
>> index 6bf0d46..d4cde79 100644
>> --- a/drivers/video/nuc900fb.c
>> +++ b/drivers/video/nuc900fb.c
>> @@ -667,7 +667,7 @@ release_irq:
>> ?release_regs:
>> ? ? ? iounmap(fbi->io);
>> ?release_mem_region:
>> - ? ? release_mem_region((unsigned long)fbi->mem, size);
>> + ? ? release_mem_region(res->start, size);
>> ?free_fb:
>> ? ? ? framebuffer_release(fbinfo);
>> ? ? ? return ret;
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com

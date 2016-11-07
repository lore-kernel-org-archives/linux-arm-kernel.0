From: dsafonov@virtuozzo.com (Dmitry Safonov)
Date: Mon, 7 Nov 2016 21:36:48 +0300
Subject: [PATCH] arm/vdso: introduce vdso_mremap hook
In-Reply-To: <20161107182734.GL1041@n2100.armlinux.org.uk>
References: <20161101172214.2938-1-dsafonov@virtuozzo.com>
 <20161107182734.GL1041@n2100.armlinux.org.uk>
Message-ID: <0d3a03e0-43ad-1e6f-a065-17e5bfdd92f4@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2016 09:27 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 01, 2016 at 08:22:14PM +0300, Dmitry Safonov wrote:
>> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
>> index 53cf86cf2d1a..d1001f87c2f6 100644
>> --- a/arch/arm/kernel/vdso.c
>> +++ b/arch/arm/kernel/vdso.c
>> @@ -54,8 +54,11 @@ static const struct vm_special_mapping vdso_data_mapping = {
>>  	.pages = &vdso_data_page,
>>  };
>>
>> +static int vdso_mremap(const struct vm_special_mapping *sm,
>> +		struct vm_area_struct *new_vma);
>
> I'd much rather avoid this forward declaration.  Is there any reason the
> function body can't be here?
>

Well, I didn't want it to be in the middle of static file variables -
those looks nice at this moment just on top of the file.
No other than that.

-- 
              Dmitry

From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 11 Aug 2011 11:43:02 -0700
Subject: [PATCH v2 2/3] ARM: i.MX51: clean up iomux-mx51.h
In-Reply-To: <CAOMZO5BiB1TFtgMLBUFcboHUXMUVaG4kkKVzW0vMt0SFuTmk4g@mail.gmail.com>
References: <1313026292-945-1-git-send-email-troy.kisky@boundarydevices.com>	<1313026292-945-2-git-send-email-troy.kisky@boundarydevices.com>
	<CAOMZO5BiB1TFtgMLBUFcboHUXMUVaG4kkKVzW0vMt0SFuTmk4g@mail.gmail.com>
Message-ID: <4E4422B6.6090609@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/11/2011 7:53 AM, Fabio Estevam wrote:
> Hi Troy,
> 
> On Wed, Aug 10, 2011 at 10:31 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
> ...
>> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
>> index df6acc0..c7f5169 100644
>> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
>> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
>> @@ -14,6 +14,8 @@
>>  #define __MACH_IOMUX_MX51_H__
>>
>>  #include <mach/iomux-v3.h>
>> +#define __NA_  0x000
>> +
> 
> Do we really need this __NA_ define? Can?t we continue just writing 0
> in the macro?
> 
> Regards,
> 
> Fabio Estevam

First, welcome back from vacation and thanks for taking the time to review.

I like the __NA_ macro for a couple of reasons.


1. It keeps the macro arguments aligned from line to line. 5 character
name so that a line that uses 0xnnn instead, usually has its arguments
aligned with a line that uses __NA_.

2. It makes it more obvious that this field is "not applicable" to this
setting.

3. NON_PAD_I is replaced with __NA_ as it has the same use, and keeps
alignment.


But if Sascha agrees with you, I will change it as it is not really
important to me. Sascha, if you do agree, please also tell me what you
want done with NON_PAD_I.

Thanks
Troy

From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 12 May 2015 22:27:07 +0300
Subject: [PATCH v2 10/17] i2c: add locomo i2c driver
In-Reply-To: <20150512192413.GE4449@schokonusskuchen.bad>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-11-git-send-email-dbaryshkov@gmail.com>
 <20150512192413.GE4449@schokonusskuchen.bad>
Message-ID: <CALT56yNHvJ1Swj2pp2JrBaJBensSP703JXQKfvivFrJOYf85QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-12 22:24 GMT+03:00 Wolfram Sang <wsa@the-dreams.de>:
> On Tue, Apr 28, 2015 at 02:55:47AM +0300, Dmitry Eremin-Solenikov wrote:
>> LoCoMo chip contains a tiny i2c controller destined to control
>> M62332 DAC. Provide a separate I2C driver for this cell.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> Thanks for the submission!
>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/mfd/locomo.h>
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/i2c-algo-bit.h>
>
> To avoid duplicates, I prefer the includes to be sorted. No need to
> resend because of that, though.
>
> Kudos for brushing up old code! Do you want the drivers go via the
> subsystem trees? Or is there a dependency so it should go in via some
> other tree in one go?

There is a header dependency -- <linux/mfd/locomo.h> is a new header.
I'd prefer for these patches to go in via one of MFD, arm-soc or ARM trees
as a whole series (if that would be ok with respective maintainers).


-- 
With best wishes
Dmitry

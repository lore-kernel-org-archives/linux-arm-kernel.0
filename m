From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 1 Jul 2011 09:28:23 +0900
Subject: [PATCH 2/3] Samsung SoC: ready to use NTC value inside kernel
In-Reply-To: <20110630090013.GP21898@n2100.arm.linux.org.uk>
References: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
	<1309422387-11546-3-git-send-email-myungjoo.ham@samsung.com>
	<20110630090013.GP21898@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikC2zUPamzactXLdLb8Szgs2o9V7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 6:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 30, 2011 at 05:26:26PM +0900, MyungJoo Ham wrote:
>> diff --git a/arch/arm/plat-samsung/dev-adc.c b/arch/arm/plat-samsung/dev-adc.c
>> index 622972c..526097a 100644
>> --- a/arch/arm/plat-samsung/dev-adc.c
>> +++ b/arch/arm/plat-samsung/dev-adc.c
>> @@ -22,6 +22,8 @@
>> ?#include <plat/devs.h>
>> ?#include <plat/cpu.h>
>>
>> +#include "../../../fs/sysfs/sysfs.h"
>
> That is a big hint that you're doing something wrong.
>
[]
>
> This is wrong on just about every level. ?It needs to be rewritten to
> avoid poking about in subsystem internal data structures, and you really
> should not be sprint-ing a value to only sscanf it later.
>
> Plus, container_of doesn't return a pointer-error code.
>
> You need to come up with a far better way of doing this altogether.
>

Um.. is there any clean and nice way to read values that are exported to sysfs?

Or if the values are only exported through sysfs (HWMON), is the only
clean way to read such values (w/o extending HWMON itself) to seperate
the HWMON device driver into two pieces: a platform driver that
provide values to somewhere sharable in kernel and a HWMON driver that
reads the values and exports them to sysfs?



Thanks.

- MyungJoo

-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858

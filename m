From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 7 Dec 2010 10:50:30 +0800
Subject: [PATCH] support PMIC mc13892
In-Reply-To: <20101206114022.249671bc@archvile>
References: <1291616735-29645-1-git-send-email-yong.shen@freescale.com>
	<20101206114022.249671bc@archvile>
Message-ID: <AANLkTimvRVZOzRSxHWCmPKh66oap2CSBen2LW3gucqUN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Mon, Dec 6, 2010 at 6:40 PM, David Jander <david.jander@protonic.nl> wrote:
>
> Hi Yong,
>
> On Mon, 6 Dec 2010 14:25:35 +0800 <yong.shen@freescale.com> wrote:
>>[...]
>> --- /dev/null
>> +++ b/include/linux/mfd/mc13892.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * Copyright 2010 Yong Shen <yong.shen@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> under
>> + * the terms of the GNU General Public License version 2 as published by the
>> + * Free Software Foundation.
>> + */
>> +
>> +#ifndef __LINUX_MFD_MC13892_H
>> +#define __LINUX_MFD_MC13892_H
>> +#include <linux/mfd/mc13xxx.h>
>> +
>> +#define MC13892_SW1 ? ? ? ? ?0
>> +#define MC13892_SW2 ? ? ? ? ?1
>> +#define MC13892_SW3 ? ? ? ? ?2
>> +#define MC13892_SW4 ? ? ? ? ?3
>> +#define MC13892_SWBST ? ? ? ?4
>> +#define MC13892_VIOHI ? ? ? ?5
>> +#define MC13892_VPLL 6
>> +#define MC13892_VDIG 7
>> +#define MC13892_VSD ?8
>> +#define MC13892_VUSB2 ? ? ? ?9
>> +#define MC13892_VVIDEO ? ? ? 10
>> +#define MC13892_VAUDIO ? ? ? 11
>> +#define MC13892_VCAM 12
>> +#define MC13892_VGEN1 ? ? ? ?13
>> +#define MC13892_VGEN2 ? ? ? ?14
>> +#define MC13892_VGEN3 ? ? ? ?15
>> +#define MC13892_VUSB 16
>> +#define MC13892_GPO1 17
>> +#define MC13892_GPO2 18
>> +#define MC13892_GPO3 19
>> +#define MC13892_GPO4 20
>> +#define MC13892_PWGT1SPI ? ? 21
>> +#define MC13892_PWGT2SPI ? ? 22
>> +#define MC13892_VCOINCELL ? ?23
>> +
>> +#endif
>
> I suppose these are needed outside the driver .c file? If so, can't these go in
> linux/mfd/mc13xxx.h?

This head is only for regulator usage, however linux/mfd/mc13xxx.h is
for multiple functions.
> The platform-data struct is in there too, so why not put the corresponding
> defines there also?
> For other subsystems, those defines that are common are prefixed MC13XXX_ and
> those that are individual, get MC13892_ or MC13783_. This makes it also easier
> and less intrusive to add support for future chips in this series....
>
This is debatable. Previously, I put it under
include/linux/regulator/, but after reviewing comments from other guys
(see previous email for mc13783), I also realized that this is private
for mc13xxx regulator drivers, basically no other users, so it is
better to stay in drivers/regulator/.

Thanks
Yong

> Best regards,
>
> --
> David Jander
> Protonic Holland.
>

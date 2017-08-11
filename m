From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 11 Aug 2017 21:08:22 +0200
Subject: [PATCH v5 06/12] mfd: wm97xx-core: core support for wm97xx Codec
References: <20170806213613.5600-1-robert.jarzmik@free.fr>
 <20170806213613.5600-7-robert.jarzmik@free.fr>
 <20170808110204.dt7bjfwkyfpbfr2w@dell>
Message-ID: <87bmnlq5w9.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee.jones@linaro.org> writes:

> On Sun, 06 Aug 2017, Robert Jarzmik wrote:

Hi Lee,

I basically agree with all your comments, so I will only answer to your
questions.
>> +#include <linux/module.h>
>
> Why separate this?
No point, for v6.
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>
> Can you use the short version?
Yeah, sure.

>> +#ifndef __LINUX_MFD_WM97XX_H
>> +#define __LINUX_MFD_WM97XX_H
>> +
>> +struct regmap;
>> +struct wm97xx_batt_pdata;
>> +struct snd_ac97;
>
> What are you using these for?
There are for the structure just below, which doesn't need the implementation
details of these structures, but does need the definition to properly compile.

>> +struct wm97xx_platform_data {
>> +	struct snd_ac97 *ac97;
>> +	struct regmap *regmap;
>> +	struct wm97xx_batt_pdata *batt_pdata;
>> +};
This is the structure "just below" I'm speaking of.

Thanks for the review.

-- 
Robert

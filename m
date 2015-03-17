From: carlo@caione.org (Carlo Caione)
Date: Tue, 17 Mar 2015 15:10:14 +0100
Subject: [PATCH v2 1/2] pinctrl: Add support for Meson8b
In-Reply-To: <CACRpkday9fO9mSr03qSy0jT1bG+Vu9qE6FUd8eZqxdnicuBTYQ@mail.gmail.com>
References: <1426064430-5826-1-git-send-email-carlo@caione.org>
 <1426064430-5826-2-git-send-email-carlo@caione.org>
 <CACRpkday9fO9mSr03qSy0jT1bG+Vu9qE6FUd8eZqxdnicuBTYQ@mail.gmail.com>
Message-ID: <CAOQ7t2avzGJU=eMaPZ8ajGiw5CaO40pn9njpN=6quiH+pii7dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 12:49 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Mar 11, 2015 at 10:00 AM, Carlo Caione <carlo@caione.org> wrote:
>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> This patch adds support for the AmLogic Meson8b SoC.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>
> (...)
>
>> diff --git a/include/dt-bindings/gpio/meson8b-gpio.h b/include/dt-bindings/gpio/meson8b-gpio.h
>> new file mode 100644
>> index 0000000..0d6b7f1
>> --- /dev/null
>> +++ b/include/dt-bindings/gpio/meson8b-gpio.h
>
> Why is this not in <dt-bindings/pinctrl/*> ?

Because meson8-gpio.h was already in <dt-bindings/gpio/*>

>> @@ -0,0 +1,31 @@
>> +/*
>> + * GPIO definitions for Amlogic Meson8b SoCs
>> + *
>> + * Copyright (C) 2015 Endless Mobile, Inc.
>> + * Author: Carlo Caione <carlo@endlessm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_MESON8B_GPIO_H
>> +#define _DT_BINDINGS_MESON8B_GPIO_H
>> +
>> +#include <dt-bindings/gpio/meson8-gpio.h>
>
> Why is this file including itself?

It's not, the file is called meson8b-gpio.h and it's including meson8-gpio.h

>> +
>> +#define DIF_0_P                0
>> +#define DIF_0_N                1
>> +#define DIF_1_P                2
>> +#define DIF_1_N                3
>> +#define DIF_2_P                4
>> +#define DIF_2_N                5
>> +#define DIF_3_P                6
>> +#define DIF_3_N                7
>> +#define DIF_4_P                8
>> +#define DIF_4_N                9
>
> Moreover, *what* is this DIF stuff and why is there no binding
> document for it?

DIF is another GPIO bank that we have only on Meson8b.

Thanks,

-- 
Carlo Caione

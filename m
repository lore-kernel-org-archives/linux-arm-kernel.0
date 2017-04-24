From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 24 Apr 2017 18:07:51 +0200
Subject: [PATCH 3/4] pinctrl: stm32: Implement .get_direction gpio_chip
 callback
In-Reply-To: <CACRpkdZG-yxMCzBqP2s37QThP7tgWKgd3pVgZGgceB+ihZs3nw@mail.gmail.com>
References: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
 <1491577811-26989-4-git-send-email-alexandre.torgue@st.com>
 <CACRpkdZG-yxMCzBqP2s37QThP7tgWKgd3pVgZGgceB+ihZs3nw@mail.gmail.com>
Message-ID: <a2ef1742-e455-69a9-ffd5-3a3cdf9ca7d6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 04/24/2017 02:37 PM, Linus Walleij wrote:
> On Fri, Apr 7, 2017 at 5:10 PM, Alexandre TORGUE
> <alexandre.torgue@st.com> wrote:
>
>> Add .get_direction() gpiochip callback in STM32 pinctrl driver.
>>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>
> (...)
>> +#include <linux/gpio.h>
>
> No this is wrong, drivers should never include this file.
> It is a deprecated consumer header.
>
>> +       if ((alt == 0) && (mode == 0))
>> +               ret = GPIOF_DIR_IN;
>> +       else if ((alt == 0) && (mode == 1))
>> +               ret = GPIOF_DIR_OUT;
>
> Just return 0 or 1, that is the driver-internal API.

Ok. I will fix it in V2.

Thanks
Alex

>
> Yours,
> Linus Walleij
>

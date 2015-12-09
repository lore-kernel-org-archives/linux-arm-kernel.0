From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 9 Dec 2015 12:56:43 +0900
Subject: [PATCH v3] bus: uniphier-system-bus: add UniPhier System Bus
 driver
In-Reply-To: <14233302.P9onBQovHz@wuerfel>
References: <1449591718-21753-1-git-send-email-yamada.masahiro@socionext.com>
 <14233302.P9onBQovHz@wuerfel>
Message-ID: <CAK7LNARJdgxKaP_Pg90LA4GR8gHUYSppdXDqYz8fYDPHKu9_Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-12-09 1:59 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>
> Just a little thought about one thing I found odd:
>
>> +static int uniphier_system_bus_check_overlap(
>> +                                     struct uniphier_system_bus_priv tmp)
>> +{
>
> Did you intentionally pass this by value?

Yes, I did not want to disturb the original one.

It is copied to a temporary storage, and sorted by the base address,
and discarded after the overlap checking.

But, you are right.   It is possible (and simpler)
to check the region overlap without sorting.


> Maybe do it explicitly using a pointer
> and memcpy to a local variable, which has a similar effect. Alternatively
> just check each newly probed child node for conflicts with any of the
> previous children. That is slightly more expensive at O(n^2) instead of O(n)
> but n is always small here and you can avoid sorting first.

Good idea.  I simplified this function in v4.



-- 
Best Regards
Masahiro Yamada

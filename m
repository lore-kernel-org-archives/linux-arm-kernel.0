From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 15 Oct 2010 23:19:07 +0800
Subject: iwmmxt signal frame handling
In-Reply-To: <201010151540.07982.arnd@arndb.de>
References: <201010141609.10889.arnd@arndb.de>
	<AANLkTimHyhLRZwR-FRtciu+0sGYYFkAh4WfLCWwu59JA@mail.gmail.com>
	<AANLkTik3Brb-XbL1GkteVs_g9J3HtYsZMQogh+KR0LB0@mail.gmail.com>
	<201010151540.07982.arnd@arndb.de>
Message-ID: <AANLkTinSJnjd9z4msto9j=gyOiuL2N4c7FOShB0fT1hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 9:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 October 2010 15:32:04 Eric Miao wrote:
>> > Acked-by: Eric Miao <eric.y.miao@gmail.com>
>> >
>>
>> This also passes the internal iwmmxt test, Haojian please add your
>> Tested-by please.
>
> Can you also confirm that the previous behaviour is broken?
> If it is, the patch is probably a candidate for the stable trees.
>

I don't believe the previous behavior is going to cause any serious issue. The
magic/size are only saved/restored only for those processes with
TIF_USING_IWMMXT
flag set. Yet this patch does seem to improve from security perspective by
zero-ing the buffer.

BTW: I didn't look too much into the code, but it seems to me that the aux can
just be zero-ed in a whole?


> ? ? ? ?Arnd
>

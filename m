From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2011 15:02:21 +0200
Subject: PB1176 broken in -rc1
In-Reply-To: <20110810155354.GP10121@e102144-lin.cambridge.arm.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<20110810153947.GK2680@pulham.picochip.com>
	<20110810155354.GP10121@e102144-lin.cambridge.arm.com>
Message-ID: <CAKnu2MqV26dG76thn-Xq-h6rg7gvrS_86-0QVT5wjviooSrJyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/10 Will Deacon <will.deacon@arm.com>:
> [Jamie]
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>> index 2fee782..91bca35 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -441,7 +441,7 @@ static inline int free_area(unsigned long pfn, unsigned long end, char *s)
>> ?static inline void poison_init_mem(void *s, size_t count)
>> ?{
>> ? ? ? u32 *p = (u32 *)s;
>> - ? ? while ((count = count - 4))
>> + ? ? for (; count != 0; count -= 4)
>> ? ? ? ? ? ? ? *p++ = 0xe7fddef0;
>> ?}
>
> Wahey, with this I can get a working system again. Thanks for saving me from
> reaching for the JTAG debugger!

Thanks for fixing Jamie, I was sure I had screwed up on TCM somehow but
it actually seems I haven't.

Yours,
Linus Walleij

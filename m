From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 23 Jan 2014 21:04:40 +1300
Subject: [PATCH 2/2] clocksource: Make clocksource register functions void
In-Reply-To: <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>	<52E0C889.6000106@prisktech.co.nz>
 <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
Message-ID: <52E0CD18.5080104@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/14 20:58, Geert Uytterhoeven wrote:
> On Thu, Jan 23, 2014 at 8:45 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>>    -static inline int clocksource_register_hz(struct clocksource *cs, u32
>>> hz)
>>> +static inline void clocksource_register_hz(struct clocksource *cs, u32
>>> hz)
>>>    {
>>>          return __clocksource_register_scale(cs, 1, hz);
>>>    }
>>
>> This doesn't make sense - you are still returning a value on a function
>> declared void, and the return is now from a function that doesn't return
>> anything either ?!?!
>> Doesn't this throw a compile-time warning??
> No, passing on void in functions returning void doesn't cause compiler
> warnings.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
Doesn't seem right to me (even if there is no warning) but that's 
probably because I used to program in Pascal where functions with no 
return were 'procedures' :)
Whether it needs to be changed or not:

For the vt8500 part -
Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony Prisk

From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 29 Jun 2010 02:42:16 +0200
Subject: PB1176 broken in 2.6.35-rc1, bisected
In-Reply-To: <1275581709.8775.14.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTikoCy2FH_5ICh-iiI_wzGj6D6oszyM-zCXkNC_4@mail.gmail.com>
	<1275518783.27834.2.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimJkaadEM1xvG30WVvEjJPZQXHwx216SeqWFKNp@mail.gmail.com>
	<1275581709.8775.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTilcyi6Tjwvz1eU211Q41RcwQAwYAAkoQwhDe-Vj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/3 Catalin Marinas <catalin.marinas@arm.com>:
> On Thu, 2010-06-03 at 09:48 +0100, Linus Walleij wrote:
>> 2010/6/3 Catalin Marinas <catalin.marinas@arm.com>:
>> > On Wed, 2010-06-02 at 23:33 +0100, Linus Walleij wrote:
>> >> my PB1176 doesn't boot properly in 2.6.35-rc1, it goes to this point
>> >> and hangs:
>> >>
>> >> (...)
>> >> Switching to clocksource timer3
>> >> NET: Registered protocol family 2
>> >> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>> >> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
>> >> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
>> >> TCP: Hash tables configured (established 4096 bind 4096)
>> >> TCP reno registered
>> >> UDP hash table entries: 256 (order: 0, 4096 bytes)
>> >> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>> >> NET: Registered protocol family 1
>> >> RPC: Registered udp transport module.
>> >> RPC: Registered tcp transport module.
>> >> RPC: Registered tcp NFSv4.1 backchannel transport module.
>> >
>> > Have you tried disabling CONFIG_CACHE_L2X0?
>>
>> Hey it works! :-)
>>
>> I suppose your latest patches will hopefully ?get the defconfig with
>> l2x0 working again in -rc2 if they're merged?
>
> I think there is an L2 erratum (and trying to get the right workaround).
> It may be triggered by commit e7c5650f6.
>
> I'll get back on the list with a patch.

Have I missed this? My 2.6.35's and -next trees still require me to
disable the L2X0 cache on the PB1176 for it to boot.

It's a bit sad if we have a 2.6.35 which cannot even boot on this
card...

Can you send me a copy of the errata so I can look at it if
you're swamped with other stuff?

Yours,
Linus Walleij

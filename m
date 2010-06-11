From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 11 Jun 2010 09:34:31 +0800
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <AANLkTilrG9sDFzAKaYi6k6dBGDC-Fgy6MIHyPHADTWs4@mail.gmail.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100610090015.GD3422@pengutronix.de>
	<AANLkTin9qGAJGSgu9Y2YjI_W8UwBITd-QYyGERcLLUgP@mail.gmail.com>
	<AANLkTilrG9sDFzAKaYi6k6dBGDC-Fgy6MIHyPHADTWs4@mail.gmail.com>
Message-ID: <AANLkTin9MfkebiNoyjnJOfc4MMGHBDVqXOMRjw4YZNao@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/11 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2010/6/10 Eric Miao <eric.miao@canonical.com>:
>
>>>> arch/arm/mach-mx1/Makefile.boot: ? ? ? ? zreladdr-y ? := 0x08008000
>>>> arch/arm/mach-shark/Makefile.boot: ? ? ? zreladdr-y ? := 0x08008000
>>>> arch/arm/mach-u300/Makefile.boot: ? ? ? ?zreladdr-y ? := 0x28E08000
>>>> arch/arm/mach-u300/Makefile.boot: ? ? ? ?zreladdr-y ? := 0x48008000
>>> I care about mx1, so I would prefer using 0xf8000000.
>>
>> Fair enough actually. And my guess of the u300 architecture is the phys
>> offset actually starts from 0x2800_0000 or 0x4800_0000 which is also
>> covered by 0xf800_0000.
>
> This is correct and incorrect. :-)
>
> In the latter case yes, it is always at 0x48000000
>
> In the other case the physical memory is indeed at 0x28000000 but
> the range reserved for the other (ACC) CPU is locked by the boot
> loader, and read/write results in a bus error. So this is compile-time
> configurable.
>
> It won't be more than a few MiB though, typically 13.
>
>> And I think u300 can actually get rid of those
>> inconsistent addresses by other means though we all know it might be
>> suffering from the communication processor side of the memory allocation.
>
> Any ideas, I'd be happy to implement them.
>

Is it possible to reserve the memory in machine_desc.fixup? though not
sure about if the memory will ever be accessed in the early stage.

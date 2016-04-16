From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 16 Apr 2016 23:47:28 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: change release address of
 spin-table
In-Reply-To: <5180506.o95UYGsKfz@wuerfel>
References: <1460716247-28049-1-git-send-email-yamada.masahiro@socionext.com>
 <20160415130549.GB8021@leverpostej>
 <CAK7LNARNUMkD79h-uG_EhRFr4gE2pDM8w57EddOMbt-mO0xc8A@mail.gmail.com>
 <5180506.o95UYGsKfz@wuerfel>
Message-ID: <CAK7LNAQJNiSxPgj8-ayaoaQ226Ub+gucu2OT6eLuyrLOS4Mutw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2016-04-16 3:48 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 15 April 2016 22:13:55 Masahiro Yamada wrote:
>> 2016-04-15 22:05 GMT+09:00 Mark Rutland <mark.rutland@arm.com>:
>> > On Fri, Apr 15, 2016 at 07:30:47PM +0900, Masahiro Yamada wrote:
>> >> The 8-byte register located at 0x59801200 on this SoC is dedicated
>> >> for waking up secondary CPUs.  We can use it and save normal memory.
>> >
>> > Generally, it is not safe to use MMIO registers to back spin-table. The
>> > kernel maps the spin table location with cacheable attributes, so there
>> > may be speculative accesses to any registes in the same (64K) page, and
>> > a writeback may be larger than the 8-byte register width (which the
>> > device might not accept, triggering an SError).
>> >
>> > Given that, I do not think this is a good idea.
>>
>> I did not know this.  Thanks for your advice!
>>
>>
>> Arnd, Olof
>>
>> Please drop this patch.
>> (I think 1/2 is still OK.)
>>
>
> Should patch 1 be applied as a bugfix for 4.6 instead?
>

Yes, please!


-- 
Best Regards
Masahiro Yamada

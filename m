From: olof@lixom.net (Olof Johansson)
Date: Fri, 24 Oct 2014 14:47:33 -0700
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141024182509.GA31232@gate.crashing.org>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <3345399.JKaCjH1LWX@wuerfel>
 <CAOesGMh3ivsvrXpKj7J8tbSXnXutXJdkfm=sbo0j_eJVAQgFsg@mail.gmail.com>
 <13842628.d0ipOeqpYt@wuerfel>
 <20141024094412.GN27405@n2100.arm.linux.org.uk>
 <20141024182509.GA31232@gate.crashing.org>
Message-ID: <CAOesGMiqR1y9avJ7dRT24qviSxv0myKiv6Ei4wLef+gfkqThvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 11:25 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Fri, Oct 24, 2014 at 10:44:12AM +0100, Russell King - ARM Linux wrote:
>> On Fri, Oct 24, 2014 at 11:13:27AM +0200, Arnd Bergmann wrote:
>> > Ok, that also explains the problems with the missing __linux__ macro, given
>> > Ard's reply about bare-metal gcc.
>> >
>> > I think we have two choices here:
>> >
>> > a) change the buildall script so it actually builds a compiler that behaves
>> >    in the way we expect for the kernel (__SIZE_TYPE__ and __linux__ at least,
>> >    possibly others)
>> >
>> > b) change the kernel to work with the way the bare-metal compiler is built,
>> >    adding -D__linux__ in the ARM Makefile and applying Ard's workaround for
>> >    __SIZE_TYPE__/__INT32_TYPE__/__UINT32_TYPE__/__UINTPTR_TYPE__.
>> >
>> > Both options are a little hacky and I don't really like them, but I think
>> > it makes sense to do one of them.
>>
>> Well, (a) is probably the right answer.  EABI had (or still has) the
>> idea that enums can be a dynamic size, and this was taken out of the
>> Linux version of EABI.  What this means is that an enum used across an
>> interface between a compiler targetting Linux and one not targetting
>> Linux may not be compatible.
>
> Hi!  Happy to hear some people still find buildall useful.
>
> The standard arm toolchains it builds are configured for arm-linux-eabi,
> not "plain" eabi.  So what goes wrong?
>
> Oh.  I changed that april this year; so just update your buildall.

Hm, my 4.9.1 was built in June, and I seem to have pulled down your
update by then (I did that in May).

> [But of course it would be good if the kernel build would work with *any*
> reasonable toolchain.  OTOH it seems that most arm toolchains aren't
> reasonable.]

Yeah, I agree with this but at some point I guess it just gets to be
_too_ crazy to try to do that.


-Olof

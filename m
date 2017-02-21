From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 21 Feb 2017 18:32:26 +0200
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <20170221162133.jch6yzpotj4s7zob@piout.net>
References: <20170220213803.7ba5591e@bbrezillon>
 <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
 <20170221112720.ynehsryprhrhzjla@piout.net>
 <CAHp75VcKjYYAw8gw8yYXrd-vzZo50WOQ06AzPx+0g9Zakzjm-w@mail.gmail.com>
 <20170221162133.jch6yzpotj4s7zob@piout.net>
Message-ID: <CAHp75VeB4eVuN5NMfAfQUtssuHezTyAM8FUswuR8FheUk1V-oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 6:21 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 21/02/2017 at 18:09:09 +0200, Andy Shevchenko wrote:
>> On Tue, Feb 21, 2017 at 1:27 PM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> > On 21/02/2017 at 13:02:21 +0200, Andy Shevchenko wrote:
>> >> Abusing platform data with pointers is also not welcome.

>> >> > (in this case, avr32).
>> >>
>> >> It's dead de facto.
>> >>
>> >> When last time did you compile kernel for it? What was the version of kernel?
>> >> Did it get successfully?
>> >>
>> >
>> > v4.10-rc3 was building successfully but had some issues in the network
>> > code.
>>
>> Newer kernel doesn't link...
>>
>> >> When are we going to remove avr32 support from kernel completely?
>>
>> > Ask that to the avr32 maintainers. It still builds and is still booted
>> > by some people. And that actually seems to be you as you reported a bug
>> > we introduced in 4.3. I don't think we had any other report after that.
>>
>> https://patchwork.kernel.org/patch/9505727/
>>
>> After that I gave up on it. Next time I will escalate directly to
>> Linus. It's a complete necrophilia. I spent already enough time to
>> look at that code. It brings now more burden than supports someone
>> somewhere.
>>
>
> As said, it builds fine without networking.

It sounds a bit sarcastic. Irony is that I *have* hardware here which
was dedicated as Network Gateway (ATNGW100). I'm accessing to it
remotely.
How useful it would be?

> Maybe the first step is to
> ask the avr32 maintainers. If you already did so,

I did it ~year or so before where another relocation bug was discovered (fixed).

> please feel free to
> send a patch to remove the whole architecture.
> The benefits for atmel will be: proper big endian support, removal of
> platform data from all the drivers, better clocksource handling.

That is good point, but if maintainers don't care, why anyone else should?
Neither do I.

>> > It can be frustrating at times to handle that platform but if it is
>> > working for someone, I don't see why we would remove it.
>>
>> How it's working if it's not linked?
>>
>
> Come on, v4.10 has just been release and v4.9 was building just fine. Do
> you really expect everybody to closely follow linux-next or update
> overnight?

What version do you use as compiler?

Today's linux-next:
$ make O=~/prj/TMP/out/avr32 C=1 CF=-D__CHECK_ENDIAN__ -j64 CONFIG_DEBUG_INFO=
y CONFIG_DEBUG_SECTION_MISMATCH=y

  CC      lib/sbitmap.o
{standard input}: Assembler messages:
{standard input}:378: Warning: Unary operator + ignored because bad
operand follows
{standard input}:378: Warning: missing operand; zero assumed
{standard input}:378: Internal error!
Assertion failure in finish_insn at .././gas/config/tc-avr32.c line 3498.
Please report this bug.
scripts/Makefile.build:294: recipe for target 'lib/sbitmap.o' failed

$ avr32-linux-gcc --version
avr32-linux-gcc (GCC) 4.2.2-atmel.1.0.8


-- 
With Best Regards,
Andy Shevchenko

From: kernel@martin.sperl.org (Martin Sperl)
Date: Sun, 10 Jan 2016 11:55:48 +0100
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
 <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
Message-ID: <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 10.01.2016, at 10:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> Hi Arnd,
> 
> On Sat, Jan 9, 2016 at 9:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Saturday 09 January 2016 09:25:54 kernel at martin.sperl.org wrote:
>>> --- a/include/dt-bindings/clock/bcm2835.h
>>> +++ b/include/dt-bindings/clock/bcm2835.h
>>> @@ -44,5 +44,6 @@
>>> #define BCM2835_CLOCK_EMMC             28
>>> #define BCM2835_CLOCK_PERI_IMAGE       29
>>> #define BCM2835_CLOCK_PWM              30
>>> +#define BCM2835_CLOCK_PCM              31
>>> 
>>> -#define BCM2835_CLOCK_COUNT            31
>>> +#define BCM2835_CLOCK_COUNT            32
>> 
>> The last line contains an incompatible change, please don't do that.
>> If you have to add another clock, do that after the BCM2835_CLOCK_COUNT
>> definition to avoid changing dts files that use that number.
> 
> While I agree this changes dts files (in an unexpected way?), not updating
> BCM2835_CLOCK_COUNT makes it definition useless. Which teaches that
> having such definitions in DT headers is not a good idea in the first place...
> 
> Hence it can better be replaced (it seems to be unused in dts files, but you
> can keep the definition to be 100% sure) by an ARRAY_SIZE() in the C driver.
> This requires changing the driver to e.g. initialize clks[] in
> bcm2835_clk_probe() based on a table instead of explicit code.

That is a more general issue with the clock driver (and there
have been already some discussions around this when implementing
the PWM clock.

So if someone with a better idea how to keep those dt-binding includes
synchronized with the definitions used by the code step forward and
propose a better solution how to get that implemented?

I guess there will be a few more occurrences of clocks that are
currently not defined, which will need to get introduced in the future
PWM and PCM were just the last in this series.

Thanks,
	Martin

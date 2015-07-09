From: roman@advem.lv (Roman Yeryomin)
Date: Thu, 09 Jul 2015 19:48:37 +0300
Subject: Gemini Soc timers
In-Reply-To: <CACRpkdYm-W8FqBgvustJUweizocmX9LtVS6Q=7j8EjF8D+H77Q@mail.gmail.com>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2131951.l0j0CIttAZ@wuerfel> <f22e65faa7d86074cda27973f83d7a52@advem.lv>
 <1781580.JRD7b0UrJA@wuerfel> <alpine.LNX.2.00.1507091343150.24357@localhost>
 <5e6214ee669fbd797ad2ef257ce52068@advem.lv>
 <CACRpkdYm-W8FqBgvustJUweizocmX9LtVS6Q=7j8EjF8D+H77Q@mail.gmail.com>
Message-ID: <975d474dd947bcef8d3dd70ef18a5c29@advem.lv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-07-09 18:48, Linus Walleij wrote:
> On Thu, Jul 9, 2015 at 3:02 PM, Roman Yeryomin <roman@advem.lv> wrote:
>> On 2015-07-09 14:58, Hans Ulli Kroll wrote:
>>> 
>>> Hi
>>> 
>>> On Thu, 9 Jul 2015, Arnd Bergmann wrote:
>>> 
>>>> On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
>>>> >
>>>> > OK, here are the minimal changes required (see attachment). Tested on
>>>> > 4.1.1
>>>> > Let me know if you want me to submit it in some other way.
>>>> >
>>>> 
>>>> The changes look ok to me. Please submit them as two separate
>>>> patches (1. set up and use timer3, 2. register sched_clock) 
>>>> according
>>>> to the Documentation/SubmittingPatches description.
>>>> 
>>>> Thanks,
>>>> 
>>>>         Arnd
>>>> 
>>> 
>>> have you seen this thread ...
>>> [PATCH 00/18] ARM: Migrate clockevent drivers to 'set-state
>>> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/423992
>>> 
>>> arch/arm/mach-gemini/time.c              | 69 
>>> ++++++++++++------------
>>> 
>>> Two or more weeks ago I send a patchset fixing this problem.
>>> At this time Arnd was in holiday and until today I was very busy at 
>>> work.
>> 
>> 
>> Sorry, I didn't see your patches.
>> Arnd requested minimal changes and until yesterday I was very busy 
>> too.
>> 
>>> I can rework my patches on top of Viresh's patchset
>> 
>> 
>> It looks that this patchset doesn't conflict with the fix needed.
> 
> Can any of you guys just look at this thing from OpenWRT:
> http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/patches-3.18/160-gemini-timers.patch;h=4b0edb45d162f751bfb7475f5b3158f28d69fe84;hb=HEAD
> 
> As usual they are just keeping it out of mainline, and this
> is adding sched_clock() and other goodies so should
> probably be upstreamed ASAP.

This is what I initially submitted here.
But Arnd wanted to see a smaller patch which only fixes gemini timer 
issue (t.i. shed clock being 100Hz instead of 25MHz).
Also I've submitted 4.1 support yesterday, but patches didn't change 
much comparing to 3.18
I would love to see all those patches/drivers in mainline - tell me 
where do I submit all that :)

Regards,
Roman

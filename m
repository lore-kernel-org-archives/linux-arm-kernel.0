From: dv@vollmann.ch (Detlef Vollmann)
Date: Thu, 10 Dec 2015 23:00:24 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <2992463.fVOGazvIkH@wuerfel>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <1802654.n0lYxNZ2px@wuerfel> <5669EB31.4050700@vollmann.ch>
 <2992463.fVOGazvIkH@wuerfel>
Message-ID: <5669F5F8.5010005@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/15 22:29, Arnd Bergmann wrote:
> On Thursday 10 December 2015 22:14:25 Detlef Vollmann wrote:
>> On 12/10/15 21:59, Arnd Bergmann wrote:
>>> On Thursday 10 December 2015 20:03:18 Detlef Vollmann wrote:
>>>> On 12/10/15 14:43, Arnd Bergmann wrote:
>>>>>    text    data     bss     dec     hex filename
>>>>>  942144   64112   17648 1023904   f9fa0 build/tmp/vmlinux-orion-allno
>>>>> 1027516   54052   20824 1102392  10d238 build/tmp/vmlinux-multi-plus-orion
>>>>> 1025320   66020   18744 1110084  10f044 build/tmp/vmlinux-orion-plus-of
>>>>>
>>>>> The diff below shows all the differences between orion-allno and
>>>>> multi-plus-orion.
>>>> How did you get the orion-allno config and how did you get it compiled?
>>>> I tried to apply your changes to my config and compile it, but
>>>> it started silentoldconfig which introduced back 'ARCH_MULTIPLATFORM'
>>>
>>> The first and third row are without my patches, once they are applied,
>>> ARCH_ORION becomes a sub-option of ARCH_MULTIPLATFORM.
>>
>> So with your patches it's no longer possible to build a small kernel, correct?
> 
> Correct. I was a bit surprised at how much object code enabling CONFIG_OF
> adds these days, it used to be a lot less, but you are right that
> disabling CONFIG_OF is not possible with the way that ARCH_MULTIPLATFORM
> is structured.
> 
> It was always the plan to move all orion5x machines over to use CONFIG_OF
> eventually, so you get that overhead one way or another, and at least
> it looks like doing multiplatform on top of OF doesn't add any noticeable
> extra overhead (the total numbers are actually smaller).
So the message is that Linux just get's bigger...
Fortunately this patch is planned for 4.5, and 4.4 is going to be an LTS kernel.

> It may also be worth investigating what has made CONFIG_OF so costly,
Probably because too much is done at runtime and too few things can
be fixed at build time.

> maybe we can reduce this a bit again.
Probably not without turning the wheel backward :-(

So for the test: yes it works, but I'm unhappy with it.

  Detlef

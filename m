From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Fri, 19 May 2017 09:59:32 +0200
Subject: [PATCH 7/8] clocksource/drivers/fttmr010: Merge Moxa into FTTMR010
In-Reply-To: <92ab6fb5-7c4a-0909-ee5b-f573751427fa@kaod.org>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
 <20170517140542.20016-8-linus.walleij@linaro.org>
 <CACPK8XdRe8Khnj3YFoQYKpKHM-5PHTqkP8Nt+jZ=eo-FThN-aw@mail.gmail.com>
 <CACRpkdaWoGYh4D3D0+3mzVDTy78O2idyDmg9+U5zJc_mfn+WLQ@mail.gmail.com>
 <CACRpkdb=HSEkFOM1APqK9q58OhADqeF7Z40oeXnVvuSDsQVkTw@mail.gmail.com>
 <92ab6fb5-7c4a-0909-ee5b-f573751427fa@kaod.org>
Message-ID: <c1104a03-df01-1edc-1c14-e13152991e67@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2017 11:09 PM, C?dric Le Goater wrote:
> On 05/18/2017 10:20 PM, Linus Walleij wrote:
>> On Thu, May 18, 2017 at 2:43 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Thu, May 18, 2017 at 9:22 AM, Joel Stanley <joel@jms.id.au> wrote:
>>>> On Wed, May 17, 2017 at 10:05 PM, Linus Walleij
>>>> <linus.walleij@linaro.org> wrote:
>>>>> This merges the Moxa Art timer driver into the Faraday FTTMR010
>>>>> driver and replaces all Kconfig symbols to use the Faraday
>>>>> driver instead. We are now so similar that the drivers can
>>>>> be merged by just adding a few lines to the Faraday timer.
>>>>
>>>> Nice work!
>>>>
>>>> I gave this a spin on hardware and it didn't work :(
>>>
>>> How typical.
>>
>> I sent a v2 patch set.
>>
>> I couldn't get qemu to work because Fedora's QEMU is not
>> up-to-date and I didn't want to venture into compiling from source...
>>
>> I did the second best and tested Gemini with downward counting
>> timers, after just adding that as general code path in the driver
>> in the commit merging the two drivers.
>>
>> Please test it, and I hope I'm not wasting too much of your time :/
>>
>> If it still doesn't work I guess I have to try to get qemu going.
>>
>> The fttmr010 branch in my git is updated:
>> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/
> 
> So a real AST2500 evb board boot fines with this branch but the timer 
> model in QEMU crashes miserably :
> 
> 	[    0.000000] NR_IRQS:16 nr_irqs:16 16
> 	Floating point exception (core dumped)

This is because the FTTMR010 driver enables a timer before setting
its reload value. This is 'against' the specs but the HW works fine
as it only starts decrementing when a reload is set.   

So, I changed the QEMU model.

Cheers,

C.   

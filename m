From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 20 Oct 2017 16:28:49 +0100
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <878tg56dtn.fsf@free-electrons.com>
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <87d163kt0m.fsf@free-electrons.com>
 <CAKv+Gu_pGeDxK_vD9iGUO486VgLsntMQwVs9wGKa79pkx7paMQ@mail.gmail.com>
 <20171004124320.GP20805@n2100.armlinux.org.uk>
 <CAKv+Gu_t+oLJKGzy3LxgLZqqYsd9eQiwZRr6dgPbqpsHnQUUxw@mail.gmail.com>
 <874lr4d8gm.fsf@free-electrons.com>
 <20171012094517.GB20805@n2100.armlinux.org.uk>
 <CAKv+Gu_+D+d+5Zi8LRmi3_sHEVx-FLLKHsi9aUUmNB8VvcHANQ@mail.gmail.com>
 <878tg56dtn.fsf@free-electrons.com>
Message-ID: <CAKv+Gu_q0A+42ht1f4o_SToWSV4OBThV=gtyfBoGYFZyKWNW5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 October 2017 at 16:25, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Ard,
>
>  On jeu., oct. 12 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 12 October 2017 at 10:45, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>>> On Thu, Oct 12, 2017 at 11:24:57AM +0200, Gregory CLEMENT wrote:
>>>> Hi Ard,
>>>>
>>>> Can we move forward to fix the booting problem ?
>>>>
>>>> What about amending your commit log with this new information and then
>>>> submit it to Russell patch system?
>>>
>>> Well, I think there's a choice that needs to be made between this
>>> approach and Arnd's approach.
>>>
>>> I'm not all that thrilled with the need to add explicit alignment to
>>> data that is inherently a byte stream, and that invariably results in
>>> unaligned data words even if you do align the start of it.  That
>>> sounds to me very much like a hack rather than a proper solution.
>>> So, right now I'm leaning more towards Arnd's solution than Ard's
>>> from what's been said in this thread.
>>>
>>
>> I agree that the struct type unaligned accessors are the best choice
>> for ARM in any case, given that it will also prevent hitting the
>> alignment fixup handler in the kernel unnecessarily.
>>
>>> However, I don't recall Arnd's patch, it's probably buried deep in
>>> my mailbox.
>>>
>>
>> Well, unless you are considering changing the unaligned accessors from
>> access_ok.h to le_struct.h as a bugfix, I think we need both patches.
>
> We will soon reach v4.14-rc6 and the Armada XP and Armada 370 still not
> boot. I also didn't see your patch in rmk patch system.
>
> Waiting for you find a agreement an other option is to remove CONFIG_EFI
> from multi_v7_defconfig as I don't really see any armv7 base board using
> EFI.
>

It is up to Russell to decide how he wants to proceed. Russell?

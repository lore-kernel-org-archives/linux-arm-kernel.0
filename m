From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Oct 2017 17:25:56 +0200
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <CAKv+Gu_+D+d+5Zi8LRmi3_sHEVx-FLLKHsi9aUUmNB8VvcHANQ@mail.gmail.com>
 (Ard Biesheuvel's message of "Thu, 12 Oct 2017 20:03:53 +0100")
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <87d163kt0m.fsf@free-electrons.com>
 <CAKv+Gu_pGeDxK_vD9iGUO486VgLsntMQwVs9wGKa79pkx7paMQ@mail.gmail.com>
 <20171004124320.GP20805@n2100.armlinux.org.uk>
 <CAKv+Gu_t+oLJKGzy3LxgLZqqYsd9eQiwZRr6dgPbqpsHnQUUxw@mail.gmail.com>
 <874lr4d8gm.fsf@free-electrons.com>
 <20171012094517.GB20805@n2100.armlinux.org.uk>
 <CAKv+Gu_+D+d+5Zi8LRmi3_sHEVx-FLLKHsi9aUUmNB8VvcHANQ@mail.gmail.com>
Message-ID: <878tg56dtn.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,
 
 On jeu., oct. 12 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 12 October 2017 at 10:45, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Thu, Oct 12, 2017 at 11:24:57AM +0200, Gregory CLEMENT wrote:
>>> Hi Ard,
>>>
>>> Can we move forward to fix the booting problem ?
>>>
>>> What about amending your commit log with this new information and then
>>> submit it to Russell patch system?
>>
>> Well, I think there's a choice that needs to be made between this
>> approach and Arnd's approach.
>>
>> I'm not all that thrilled with the need to add explicit alignment to
>> data that is inherently a byte stream, and that invariably results in
>> unaligned data words even if you do align the start of it.  That
>> sounds to me very much like a hack rather than a proper solution.
>> So, right now I'm leaning more towards Arnd's solution than Ard's
>> from what's been said in this thread.
>>
>
> I agree that the struct type unaligned accessors are the best choice
> for ARM in any case, given that it will also prevent hitting the
> alignment fixup handler in the kernel unnecessarily.
>
>> However, I don't recall Arnd's patch, it's probably buried deep in
>> my mailbox.
>>
>
> Well, unless you are considering changing the unaligned accessors from
> access_ok.h to le_struct.h as a bugfix, I think we need both patches.

We will soon reach v4.14-rc6 and the Armada XP and Armada 370 still not
boot. I also didn't see your patch in rmk patch system.

Waiting for you find a agreement an other option is to remove CONFIG_EFI
from multi_v7_defconfig as I don't really see any armv7 base board using
EFI.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

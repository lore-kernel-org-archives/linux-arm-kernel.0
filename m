From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 16 Nov 2013 17:26:45 -0800
Subject: [PATCH] arm/arm64: KVM: Fix hyp mappings of vmalloc regions
In-Reply-To: <52880017.8060006@ti.com>
References: <1384557880-14107-1-git-send-email-christoffer.dall@linaro.org>
 <87846f3195cadcae32824120f78e3c9d@www.loen.fr>
 <20131116171524.GK20516@lvm> <52880017.8060006@ti.com>
Message-ID: <CAMJs5B-4ABJ1PBhBaJOiqhF_CekBPQ3QwpZ_yyQsEkSO_tPcXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2013 15:30, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> On Saturday 16 November 2013 12:15 PM, Christoffer Dall wrote:
>> On Sat, Nov 16, 2013 at 10:01:01AM +0000, Marc Zyngier wrote:
>>> On 2013-11-15 23:24, Christoffer Dall wrote:
>>>> Using virt_to_phys on percpu mappings is horribly wrong as it may be
>>>> backed by vmalloc.  Introduce kvm_kaddr_to_phys which translates both
>>>> types of valid kernel addresses to the corresponding physical
>>>> address.
>>>>
>>>> At the same time resolves a typing issue where we were storing the
>>>> physical address as a 32 bit unsigned long (on arm), truncating the
>>>> physical address for addresses above the 4GB limit.  This caused
>>>> breakage on Keystone.
>>>>
>>>> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>> ---
>>>>
>>>> This patch is loosely based on Marc's previous patch from today but
>>>> instead of introducing another Hyp mapping function, it fixes the
>>>> existing one to deal with both kinds of kernel addresses.
>>>
>>> Looks good to me! This should probably be merged quickly (after
>>> testing by Santosh), and possibly Cc-ed to stable.
>>>
>> Agreed, Santhos, can you give this a quick spin?
>>
> Works as expected.
>
great, I'll merge the patch.  Thanks for testing it.

-Christoffer

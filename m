From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 7 Jul 2017 10:31:57 -0700
Subject: [PATCH] ARM: mvebu: use __pa_symbol in the mv98dx3236 platform
 SMP code
In-Reply-To: <87a84gd69w.fsf@free-electrons.com>
References: <20170707075928.2938-1-gregory.clement@free-electrons.com>
 <87a84gd69w.fsf@free-electrons.com>
Message-ID: <8b7c8f7d-f507-9abf-ff65-bc170f58d63d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2017 01:02 AM, Gregory CLEMENT wrote:
> Hi Florian,
> 
> I forgot to CC you on this patch.
> 
> Gregory
> 
>  On ven., juil. 07 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> 
>> As we already did for Armada XP switch from virt_to_phys() to
>> __pa_symbol().
>>
>> The reason for it was well explained by Mark Rutland so let's quote him:
>>
>> "virt_to_phys() is intended to operate on the linear/direct mapping of
>> RAM.
>>
>> __pa_symbol() is intended to operate on the kernel mapping, which may
>> not be in the linear/direct mapping on all architectures. e.g. arm64 and
>> x86_64 map the kernel image and RAM separately.
>>
>> On 32-bit ARM the kernel image mapping is tied to the linear/direct
>> mapping, so that works, but as it's semantically wrong (and broken for
>> generic code), the DEBUG_VIRTUAL checks complain."
>>
>> Fixes: db88977894ab ("arm: mvebu: support for SMP on 98DX3336 SoC")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian

From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Feb 2015 11:35:04 +0000
Subject: [PATCH v3] arm64: mm: increase VA range of identity map
In-Reply-To: <20150226112717.GA17992@localhost>
References: <1424942215-5505-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150226112717.GA17992@localhost>
Message-ID: <CAKv+Gu-uDbdi-3SN=obibs+iD+KJEj9s3tseseXY3vDGT26cRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2015 at 11:27, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Feb 26, 2015 at 09:16:55AM +0000, Ard Biesheuvel wrote:
>> The page size and the number of translation levels, and hence the supported
>> virtual address range, are build-time configurables on arm64 whose optimal
>> values are use case dependent. However, in the current implementation, if
>> the system's RAM is located at a very high offset, the virtual address range
>> needs to reflect that merely because the identity mapping, which is only used
>> to enable or disable the MMU, requires the extended virtual range to map the
>> physical memory at an equal virtual offset.
>>
>> This patch relaxes that requirement, by increasing the number of translation
>> levels for the identity mapping only, and only when actually needed, i.e.,
>> when system RAM's offset is found to be out of reach at runtime.
>>
>> Tested-by: Laura Abbott <lauraa@codeaurora.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> The patch looks fine to me, though most likely for 4.1; in the meantime:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>

Thanks. Either 4.0 or 4.1 is fine by me.

> Do you plan to look at the KVM aspect as well or we leave it with the
> KVM maintainers?
>

I am looking into that atm.

-- 
Ard.

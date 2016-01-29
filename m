From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 29 Jan 2016 19:49:19 +0100
Subject: [PATCH v4 00/22] arm64: implement support for KASLR
In-Reply-To: <20160129182657.GI20099@e104818-lin.cambridge.arm.com>
References: <1453828249-14467-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160129182657.GI20099@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu_ANOm_skhVVBwK-1+yVP614FWeCo87aGN7iFjmUj95Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

giOn 29 January 2016 at 19:26, Catalin Marinas <catalin.marinas@arm.com> wrote:
> Hi Ard,
>
> On Tue, Jan 26, 2016 at 06:10:27PM +0100, Ard Biesheuvel wrote:
>> Code can be found here:
>> git://git.linaro.org/people/ard.biesheuvel/linux-arm.git arm64-kaslr-v4a
>> https://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/heads/arm64-kaslr-v4a
>
> The overall series looks fine but I'd like more time to review the KASLR
> part together with the module PLT stuff.
>
> So could you please split this series in 2-3 parts for easy merging
> (possibly without the KASLR part, it depends on how the review goes)?

Sure

> It
> looks like a mix of features in random order like huge-vmap, relative
> extable, kernel memory layout changes, kernel load address, PIE and
> KASLR. So something like:
>
> 1. relative extable

This has been picked up by akpm in the mean time

> 2. huge-vmap

This is a single patch which is completely independent. I don't expect
it to conflict when applied in isolation.

> 3. kernel memory layout changes (moving kernel to the base of vmalloc
> range)
> 4. allow kernel loading at different phys offsets
> 5. module PLTs, relocations, PIE, relative kallsyms, KASLR

Relative kallsyms has also been picked up by akpm

> 6. efi_get_random_bytes
>
> 1-4 can be in the same branch but I currently find it hard to
> cherry-pick the non-PIE/non-KASLR patches without conflicts.
>

I think 3 logically coherent series that apply in sequence is
feasible. I will look into this on Monday

-- 
Ard.

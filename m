From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Jan 2016 18:26:57 +0000
Subject: [PATCH v4 00/22] arm64: implement support for KASLR
In-Reply-To: <1453828249-14467-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1453828249-14467-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160129182657.GI20099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, Jan 26, 2016 at 06:10:27PM +0100, Ard Biesheuvel wrote:
> Code can be found here:
> git://git.linaro.org/people/ard.biesheuvel/linux-arm.git arm64-kaslr-v4a
> https://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/heads/arm64-kaslr-v4a

The overall series looks fine but I'd like more time to review the KASLR
part together with the module PLT stuff.

So could you please split this series in 2-3 parts for easy merging
(possibly without the KASLR part, it depends on how the review goes)? It
looks like a mix of features in random order like huge-vmap, relative
extable, kernel memory layout changes, kernel load address, PIE and
KASLR. So something like:

1. relative extable
2. huge-vmap
3. kernel memory layout changes (moving kernel to the base of vmalloc
range)
4. allow kernel loading at different phys offsets
5. module PLTs, relocations, PIE, relative kallsyms, KASLR
6. efi_get_random_bytes

1-4 can be in the same branch but I currently find it hard to
cherry-pick the non-PIE/non-KASLR patches without conflicts.

Thanks.

-- 
Catalin

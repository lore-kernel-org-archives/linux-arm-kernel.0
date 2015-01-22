From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Jan 2015 17:37:58 +0000
Subject: [PATCH] arm64/efi: move virtmap init to early initcall
In-Reply-To: <20150122155924.GC28096@e104818-lin.cambridge.arm.com>
References: <1421920900-27028-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150122155924.GC28096@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-TLnXOHtq1+rWJRPdLbTfau0t_c0+2KAbqk85wrF1zDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2015 at 15:59, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Jan 22, 2015 at 10:01:40AM +0000, Ard Biesheuvel wrote:
>> Now that the create_mapping() code in mm/mmu.c is able to support
>> setting up kernel page tables at initcall time, we can move the whole
>> virtmap creation to arm64_enable_runtime_services() instead of having
>> a distinct stage during early boot. This also allows us to drop the
>> arm64-specific EFI_VIRTMAP flag.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Applied. Thanks.
>

Wow that was quick. I noticed that you mangled my S-o-b line though:
not something I care deeply about, just a FYI

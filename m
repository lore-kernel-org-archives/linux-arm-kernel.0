From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Apr 2018 17:17:30 +0200
Subject: [PATCH] efi/libstub/arm64: handle randomized TEXT_OFFSET
In-Reply-To: <20180424101500.e5c032b91e87a354e92344c5@arm.com>
References: <20180424110058.29344-1-mark.rutland@arm.com>
 <20180424101500.e5c032b91e87a354e92344c5@arm.com>
Message-ID: <CAKv+Gu9vUFQVUyq7yNKvmXFLvh4yfJq6wE2wYbAEXWXZ4rQH+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2018 at 17:15, Kim Phillips <kim.phillips@arm.com> wrote:
> On Tue, 24 Apr 2018 12:00:58 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
>
>> When CONFIG_RANDOMIZE_TEXT_OFFSET is selected, TEXT_OFFSET is an
>> arbitrary multiple of PAGE_SIZE in the interval [0, 2MB).
>>
>> The EFI stub doesn't accuont for this, and only handles the case where
>> TEXT_OFFSET is multiple of EFI_KIMG_ALIGN. This can result in the kernel
>> being loaded to an erroneous physical alignment. This has been observed
>> to result in spurious stack overflow reports and failure to make use of
>> the IRQ stacks, and theoretically could result in a number of other
>> issues.
>>
>> We can OR in the low bits of TEXT_OFFSET to ensure that we have the
>> necessary offset (and hence have the necessary alignment), so let's do
>> that.
>>
>> Fixes: 6f26b3671184c36d ("arm64: kaslr: increase randomization granularity")
>> Reported-by: Kim Phillips <kim.phillips@arm.com>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: linux-efi at vger.kernel.org
>> ---
>
> Tested-by: Kim Phillips <kim.phillips@arm.com>
>

Thanks all

Queued in efi/urgent.

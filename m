From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 29 Dec 2014 09:25:15 +0000
Subject: [PATCH v4 4/8] efi: efistub: allow allocation alignment larger
 than EFI_PAGE_SIZE
In-Reply-To: <20141223164549.GB3810@pd.tnic>
References: <1419245944-2424-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419245944-2424-5-git-send-email-ard.biesheuvel@linaro.org>
 <20141223164549.GB3810@pd.tnic>
Message-ID: <CAKv+Gu_+scCHYuXccgsvn9THsbP24OfyjvjN9XtEVe4nMdQtig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 December 2014 at 16:45, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Dec 22, 2014 at 10:59:00AM +0000, Ard Biesheuvel wrote:
>> On systems with 64 KB pages, it is preferable for UEFI memory map
>> entries to be 64 KB aligned multiples of 64 KB, because it relieves
>> us of having to deal with the residues.
>> So, if EFI_ALLOC_ALIGN is #define'd by the platform, use it to round
>> up all memory allocations made.
>>
>> Acked-by: Matt Fleming <matt.fleming@intel.com>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Acked-by: Borislav Petkov <bp@suse.de>
>

Thanks Boris.

Do you have any comments regarding patches #3 and #6 in this series?
Patch #3 is actual common code, but patch #6 also touches a file under
drivers/firmware/efi/libstub (but it is only used by arm64 atm) With
your acks on those, I could ask Catalin or Will to take the whole
series through the arm64 tree.

Regards,
Ard.

From: labbott@redhat.com (Laura Abbott)
Date: Mon, 16 Nov 2015 14:50:48 -0800
Subject: [PATCHv2] arm64: Fix R/O permissions in mark_rodata_ro
In-Reply-To: <CAKv+Gu_xkiH8w2gor8SEp4y2UV9KSKTp9Kjtr6C9aU7XduZ06g@mail.gmail.com>
References: <CAKv+Gu8Z7bkogGUGcNbuSoEbUBAwVmtFNhX9VcbypucaUGd+HQ@mail.gmail.com>
 <1447359670-23652-1-git-send-email-labbott@fedoraproject.org>
 <CAKv+Gu_xkiH8w2gor8SEp4y2UV9KSKTp9Kjtr6C9aU7XduZ06g@mail.gmail.com>
Message-ID: <564A5DC8.9090307@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2015 11:38 PM, Ard Biesheuvel wrote:
> On 12 November 2015 at 21:21, Laura Abbott <labbott@fedoraproject.org> wrote:
>> The permissions in mark_rodata_ro trigger a build error
>> with STRICT_MM_TYPECHECKS. Fix this by introducing
>> PAGE_KERNEL_ROX for the same reasons as PAGE_KERNEL_RO.
>
> Forgive the bikeshedding but perhaps PAGE_KERNEL_EXEC_RO is more consistent?
>

powerpc was using PAGE_KERNEL_ROX so I went with that. Blame powerpc ;)
  
>>  From Ard:
>>
>> "PAGE_KERNEL_EXEC has PTE_WRITE set as well, making the range
>> writeable under the ARMv8.1 DBM feature, that manages the
>> dirty bit in hardware (writing to a page with the PTE_RDONLY
>> and PTE_WRITE bits both set will clear the PTE_RDONLY bit in that case)"
>>
>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>

Thanks,
Laura

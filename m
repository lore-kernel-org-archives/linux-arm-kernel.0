From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 1 Jul 2014 20:55:20 +0200
Subject: [PATCH v2 0/5] efistub: convert into static library
In-Reply-To: <20140701183906.GH7539@console-pimps.org>
References: <1403792617-25792-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140701183906.GH7539@console-pimps.org>
Message-ID: <CAKv+Gu8eN4s9V6=mmQFpMDKuuMRE0y5T6pxk27=BLMFRX1O57w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 July 2014 20:39, Matt Fleming <matt@console-pimps.org> wrote:
> On Thu, 26 Jun, at 04:23:32PM, Ard Biesheuvel wrote:
>> This is v2 of the series to change the #include "../../../../xxx.c" pattern
>> into a static library linked into either the kernel (arm64) or a separate boot
>> decompressor (x86, ARM).
>>
>> Changes since v1:
>> - added patch #1 to change EFI_ERROR, it is not a result code defined by UEFI so
>>   it should only be returned by get_dram_base() and efi_entry()
>> - added a section to libstub Makefile to clean CFLAGS of stack protecter and
>>   other options that are inappropriate for the stub
>> - rebased onto the UEFI Runtime Services NEON patches (re)posted earlier today
>>
>> Ard Biesheuvel (5):
>>   efi/arm64: avoid EFI_ERROR as a generic return code
>>   efi/x86: efistub: move shared dependencies to <asm/efi.h>
>>   efi/arm64: efistub: move shared dependencies to <asm/efi.h>
>>   efi: efistub: refactor stub components
>>   efi: efistub: convert into static library
>
> Thanks Ard. I've picked these up.
>

OK, thanks. One tiny snag that I would like to fix up once we have
some Acks to add: I just noticed that i removed the 'static' from
handle_kernel_image()'s definition from arm64 in 4/5, but removed it
from the forward declaration in 5/5, which likely breaks bisect for
arm64 if you happen to end up right in the middle.

Regards,
Ard.

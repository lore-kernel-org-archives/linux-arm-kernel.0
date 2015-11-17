From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Nov 2015 10:18:37 +0100
Subject: [PATCH v2 05/12] arm64/efi: refactor EFI init and runtime code
 for reuse by 32-bit ARM
In-Reply-To: <20151116184919.GD8644@n2100.arm.linux.org.uk>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-6-git-send-email-ard.biesheuvel@linaro.org>
 <20151116184919.GD8644@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu9+Pw3vv-EiZYg1zNmoBYPqcWY=XECzTcVV8WtY5WjpTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2015 at 19:49, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 16, 2015 at 07:32:30PM +0100, Ard Biesheuvel wrote:
>> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
>> index e62ee5df96ca..ad11ba6964f6 100644
>> --- a/drivers/firmware/efi/arm-runtime.c
>> +++ b/drivers/firmware/efi/arm-runtime.c
>> @@ -23,18 +23,15 @@
>>
>>  #include <asm/cacheflush.h>
>>  #include <asm/efi.h>
>> -#include <asm/tlbflush.h>
>> -#include <asm/mmu_context.h>
>> +#include <asm/io.h>
>
> Shouldn't this be linux/io.h ?
>

Yes. Will change it for v3

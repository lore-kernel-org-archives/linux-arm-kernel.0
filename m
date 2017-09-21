From: keescook@chromium.org (Kees Cook)
Date: Thu, 21 Sep 2017 10:52:40 -0700
Subject: [PATCH] arm64: Always use REFCOUNT_FULL
In-Reply-To: <20170921174548.GM32076@ZenIV.linux.org.uk>
References: <20170920204959.GA79741@beast>
 <20170921174548.GM32076@ZenIV.linux.org.uk>
Message-ID: <CAGXu5jK_2N+VQ43UC6Fi-umcqjVdmpHpPiAf-Qr+4vL9tWRqFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 10:45 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Sep 20, 2017 at 01:49:59PM -0700, Kees Cook wrote:
>> As discussed at the Linux Security Summit, arm64 prefers to use
>> REFCOUNT_FULL by default. This enables it for the architecture.
>>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: hw.likun at huawei.com
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/arm64/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 0df64a6a56d4..9fe7a7f4c94c 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -119,6 +119,7 @@ config ARM64
>>       select PCI_ECAM if ACPI
>>       select POWER_RESET
>>       select POWER_SUPPLY
>> +     select REFCOUNT_FULL
>
> Umm...  That does a bit more than "on by default", unless I'm
> misreading it.  More like "on, and you can't opt out"...

True, I should rephrase it to say "arm64 maintainers perfer to use
REFCOUNT_FULL unconditionally".

-Kees

-- 
Kees Cook
Pixel Security

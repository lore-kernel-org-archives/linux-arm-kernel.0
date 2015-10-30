From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 30 Oct 2015 12:57:48 +0100
Subject: [PATCH] arm64/efi: move arm64 specific stub C code to libstub
In-Reply-To: <20151029183933.GU8899@e104818-lin.cambridge.arm.com>
References: <1445611694-31838-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151029183933.GU8899@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu80ztGR88-FK5rBUgDJ9vk+c3Kz+L8wp7aUpx2FPE9-cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2015 at 19:39, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Oct 23, 2015 at 04:48:14PM +0200, Ard Biesheuvel wrote:
>> Now that we added special handling to the C files in libstub, move
>> the one remaining arm64 specific EFI stub C file to libstub as
>> well, so that it gets the same treatment. This should prevent future
>> changes from resulting in binaries that may execute incorrectly in
>> UEFI context.
>>
>> With efi-entry.S the only remaining EFI stub source file under
>> arch/arm64, we can also simplify the Makefile logic somewhat.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> I would like to suggest that this be taken on top of the stuff that is
>> queued for 4.4 at the moment (if it is not too late already).
>
> Applied. Thanks.
>

Please note (before you push it out), that Will just pulled a 4.3-rc
fix that changes arch/arm64/kernel/efi-stub.c

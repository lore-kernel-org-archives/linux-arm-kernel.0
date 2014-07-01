From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 1 Jul 2014 15:35:09 +0200
Subject: [PATCH v2 1/2] efi/x86: move UEFI Runtime Services wrappers to
 generic code
In-Reply-To: <20140701133033.GD7539@console-pimps.org>
References: <1403777346-28629-1-git-send-email-ard.biesheuvel@linaro.org>
 <1403777346-28629-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140701133033.GD7539@console-pimps.org>
Message-ID: <CAKv+Gu_hyXaFEydpRQCB0vP260oJpFftytN_Ex++shMdpFpafg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 July 2014 15:30, Matt Fleming <matt@console-pimps.org> wrote:
> On Thu, 26 Jun, at 12:09:05PM, Ard Biesheuvel wrote:
>> In order for other archs (such as arm64) to be able to reuse the virtual mode
>> function call wrappers, move them to drivers/firmware/efi/runtime-wrappers.c.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> [...]
>
>> @@ -54,6 +54,13 @@ config EFI_PARAMS_FROM_FDT
>>         the EFI runtime support gets system table address, memory
>>            map address, and other parameters from the device tree.
>>
>> +config EFI_RUNTIME_WRAPPERS
>> +     bool
>> +     help
>> +       Selected by the arch if it needs to wrap UEFI Runtime Services calls,
>> +       in which case it needs to provide #definitions of efi_call_virt and
>> +       __efi_call_virt in <asm/efi.h>
>> +
>>  endmenu
>
> Actually, could we drop this help text?
>
> That may seem like a backwards step, but I have concerns that we'll fail
> to keep this help text in sync with the code. Furthermore, by providing
> help text that kinda says, "casual users need the help text to
> understand when to enable this feature". Clearly that's not what this
> Kconfig symbol is for.
>
> Most of the other guard Kconfig symbols don't provide this kind of text,
> and I think there's good reason to follow suit.
>
> What do you think?
>

I agree, but I kind of followed the example of the Kconfig symbols in
the vicinity.
So sure, rip it out. Or would you like me to do a v(n+1)?

-- 
Ard.

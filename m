From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 1 Dec 2016 19:53:47 +0800
Subject: [PATCH v14] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <20161201114137.herpemkbg3rqxrc4@pd.tnic>
References: <1470834168-1780-1-git-send-email-fu.wei@linaro.org>
 <20161201114137.herpemkbg3rqxrc4@pd.tnic>
Message-ID: <CADyBb7vYzFnJjQvbMvGkqDvfBWL4jofMDhjPCvwS6u0S-yw3sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 1 December 2016 at 19:41, Borislav Petkov <bp@suse.de> wrote:
> On Wed, Aug 10, 2016 at 09:02:48PM +0800, fu.wei at linaro.org wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> This patch provides APEI arch-specific bits for aarch64
>>
>> Meanwhile,
>> (1)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
>> a generic place.
>> (2)select HAVE_ACPI_APEI when EFI and ACPI is set on ARM64,
>> because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.
>
> ...
>
>> @@ -110,8 +111,27 @@ static inline const char *acpi_get_enable_method(int cpu)
>>  }
>>
>>  #ifdef       CONFIG_ACPI_APEI
>> +/*
>> + * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
>> + * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode by
>> + * boot parameter(acpi=nocmcff). But we don't have this IA-32 specific
>
> Make that
>
> "... with a kernel command line parameter "acpi=nocmcoff"."
>
> Please fix that up when applying.
>
> With that:
>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Great thanks for your rapidly feedback :-)

will send v15 with that fix  immediately

>
> Thanks!
>
> --
> Regards/Gruss,
>     Boris.
>
> SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
> --



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat

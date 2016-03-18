From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 18 Mar 2016 12:02:25 +0100
Subject: [PATCH 1/8] efi: make install_configuration_table() boot service
 usable
In-Reply-To: <20160318105939.GO2619@codeblueprint.co.uk>
References: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
 <1457588408-19309-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160318105939.GO2619@codeblueprint.co.uk>
Message-ID: <CAKv+Gu9tS9fKM_dHK7J+TraotfEwRXbQ7vzNrErb1CteP4eu4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2016 at 11:59, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Thu, 10 Mar, at 12:40:01PM, Ard Biesheuvel wrote:
>> This patch redeclares efi_boot_services_t::install_configuration_table
>> as a function pointer so that the boot service is callable as a function.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  include/linux/efi.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Any chance you could fold this patch into the one that actually uses
> install_configuration_table() on ARM? That way it's clear to see where
> the users are.
>

Sure. Patch #2 actually does the same for locate_handle()


>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index e747eb08b2be..8ba6eb7863aa 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -283,7 +283,7 @@ typedef struct {
>>       void *register_protocol_notify;
>>       void *locate_handle;
>>       void *locate_device_path;
>> -     void *install_configuration_table;
>> +     efi_status_t (*install_configuration_table)(efi_guid_t *, void *);
>>       void *load_image;
>>       void *start_image;
>>       void *exit;
>> --
>> 1.9.1
>>

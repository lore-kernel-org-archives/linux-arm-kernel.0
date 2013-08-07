From: roy.franz@linaro.org (Roy Franz)
Date: Wed, 7 Aug 2013 10:12:33 -0700
Subject: [PATCH 04/17] Rename memory allocation/free functions
In-Reply-To: <20130807130906.GD2515@console-pimps.org>
References: <1375847113-24884-1-git-send-email-roy.franz@linaro.org>
 <1375847113-24884-5-git-send-email-roy.franz@linaro.org>
 <20130807130906.GD2515@console-pimps.org>
Message-ID: <CAFECyb_r9yMVeWnBLe3Fn2Zg4i6L=7E7RDQQqVe_DfC6oTmqgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 7, 2013 at 6:09 AM, Matt Fleming <matt@console-pimps.org> wrote:
> On Tue, 06 Aug, at 08:45:00PM, Roy Franz wrote:
>> Rename them to be more similar, as low_free() could be used to free
>> memory allocated by both high_alloc() and low_alloc().
>> high_alloc() -> efi_high_alloc()
>> low_alloc()  -> efi_low_alloc()
>> low_free()   -> efi_free()
>>
>> Signed-off-by: Roy Franz <roy.franz@linaro.org>
>> ---
>>  arch/x86/boot/compressed/eboot.c       |   19 ++++++++++---------
>>  drivers/firmware/efi/efi-stub-helper.c |   16 ++++++++--------
>>  2 files changed, 18 insertions(+), 17 deletions(-)
>
> [...]
>
>> @@ -163,10 +163,10 @@ fail:
>>  }
>>
>>  /*
>> - * Allocate at the lowest possible address.
>> + * Allocate at the lowest possible address, that is not below 'min'
>>   */
>> -static efi_status_t low_alloc(efi_system_table_t *sys_table_arg,
>> -             unsigned long size, unsigned long align,
>> +static efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>> +                           unsigned long size, unsigned long align,
>>                             unsigned long *addr)
>>  {
>>       unsigned long map_size, desc_size;
>
> Whoops, did this change to the comment slip in from some other patch?
>
> --
> Matt Fleming, Intel Open Source Technology Center

Yes it did - that should be in a later patch that makes that change.

Roy

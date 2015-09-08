From: ahs3@redhat.com (Al Stone)
Date: Tue, 8 Sep 2015 17:00:05 -0600
Subject: [PATCH v2 1/5] ACPI: add in a bad_madt_entry() function to
 eventually replace the macro
In-Reply-To: <55EDADF5.5060008@arm.com>
References: <1440022048-6285-1-git-send-email-al.stone@linaro.org>
 <1440022048-6285-2-git-send-email-al.stone@linaro.org>
 <55EDADF5.5060008@arm.com>
Message-ID: <55EF6875.9000404@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2015 09:32 AM, Sudeep Holla wrote:
> Hi Al,
> 
> On 19/08/15 23:07, Al Stone wrote:
> 
> I finally got a chance to try this series on Juno. Well it exposed a firmware
> bug in MADT table :)

What?  The code did what it was supposed to do :-)?  Very cool.  Good to know.

I talked to Graeme a bit, too, and he had some good suggestions for clean up.
I'll post a v3 tomorrow.

> [..]
> 
>>                  acpi_tbl_entry_handler handler,
>> @@ -245,6 +484,8 @@ acpi_parse_entries(char *id, unsigned long table_size,
>>                 table_end) {
>>                  if (entry->type == entry_id
>>                      && (!max_entries || count < max_entries)) {
>> +                       if (bad_madt_entry(table_header, entry))
>> +                               return -EINVAL;
> 
> Not sure if we can have the above check here unconditionally.
> Currently I can see there are 2 other users of acpi_parse_entries i.e.
> PCC and NUMA. So may be it can be made conditional or return success for
> non-MADT tables from bad_madt_entry ?

I'll double check these uses.  I thought I had before, and based on what I
saw the check would be reasonable.  It never hurts to check again, though.

> Other than that, you can add for ARM64 specific parts:
> Reviewed-and-tested-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

> Regards,
> Sudeep
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------

From: roy.lists@gmail.com (Roy Franz (HPE))
Date: Thu, 12 May 2016 14:30:26 -0700
Subject: [PATCH v5 0/1] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <3b6d5be3-40ab-94dc-2590-8b2638cbdc15@redhat.com>
References: <1461619287-27211-1-git-send-email-al.stone@linaro.org>
 <3b6d5be3-40ab-94dc-2590-8b2638cbdc15@redhat.com>
Message-ID: <CAK-u0Q=zrPhOnkut1vJgAS5DKKRSD2oVxCeZen_6LqvYCR5nCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 2, 2016 at 1:19 PM, Al Stone <ahs3@redhat.com> wrote:
> On 04/25/2016 03:21 PM, Al Stone wrote:
>> The ACPI 6.1 specification was recently released at the end of January
>> 2016, but the arm64 kernel documentation for the use of ACPI was written
>> for the 5.1 version of the spec.  There were significant additions to the
>> spec that had not yet been mentioned -- for example, the 6.0 mechanisms
>> added to make it easier to define processors and low power idle states,
>> as well as the 6.1 addition allowing regular interrupts (not just from
>> GPIO) be used to signal ACPI general purpose events.
>>
>> This patch reflects going back through and examining the specs in detail
>> and updating content appropriately.  Whilst there, a few odds and ends of
>> typos were caught as well.  This brings the documentation up to date with
>> ACPI 6.1 for arm64.
>>
>> Changes for v5:
>>    -- Miscellaneous typos and corrections (Lorenzo Pieralisi)
>>    -- Add linux-acpi@ ML to the distribution list (Alexey Klimov)
>>    -- Corrections to CPPC information (Alexey Klimov)
>>    -- ACK from Lorenzo Pieralisi
>>    -- Updated bibliographic info (Al Stone)
>>
>> Changes for v4:
>>    -- Clarify that IORT can sometimes be optional (Jon Masters).
>>    -- Remove "Use as needed" descriptions of ACPI objects; they provide
>>       no substantive information and doing so simplifies maintenance of
>>       this document over time.  These have been replaced with a simpler
>>       notice that states that unless otherwise noted, do what the ACPI
>>       specification says is needed.
>>    -- Corrected the _OSI object usage recommendation; it described kernel
>>       behavior that does not exist (Al Stone).
>>
>> Changes for v3:
>>    -- Clarify use of _LPI/_RDI (Vikas Sajjan)
>>    -- Whitespace cleanup as pointed out by checkpatch
>>
>> Changes for v2:
>>    -- Clean up white space (Harb Abdulhahmid)
>>    -- Clarification on _CCA usage (Harb Abdulhamid)
>>    -- IORT moved to required from recommended (Hanjun Guo)
>>    -- Clarify IORT description (Hanjun Guo)
>>
>>
>> Al Stone (1):
>>   ARM64: ACPI: Update documentation for latest specification version
>>
>>  Documentation/arm64/acpi_object_usage.txt | 343 ++++++++++++++++--------------
>>  Documentation/arm64/arm-acpi.txt          |  40 ++--
>>  2 files changed, 213 insertions(+), 170 deletions(-)
>>
>
> Ping?  If there are no further comments, can this be pulled in through
> either the documentation or arm64 tree?
>
> Thanks.

I've read through this - looks good to me.  I think it provides useful
guidance to
reference as we work on getting good ACPI support provided by various platforms
under development.

Reviewed-by: Roy Franz <roy.franz@hpe.com>

>
> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3 at redhat.com
> -----------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 3 Feb 2016 15:45:24 +0000
Subject: [PATCH v1 2/5] arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
In-Reply-To: <56B21D34.8060106@arm.com>
References: <1454432611-21333-1-git-send-email-james.morse@arm.com>
 <1454432611-21333-3-git-send-email-james.morse@arm.com>
 <56B1EEC5.9020506@arm.com> <56B21D34.8060106@arm.com>
Message-ID: <56B22094.7020408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/16 15:31, James Morse wrote:
> Hi Suzuki,


>>>
>>> +static struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>>> +    ARM64_FTR_END,
>>
>> It will be good to see all the defined fields in id_aa64mmfr2 added here in
>> this patch. You could also move the definition of UA0 field from the next patch
>> to here.
>
> Okay, what are the rules for unsupported features?
>
> UAO support isn't added until a later patch, I assumed it was best to add the
> definition as part of that patch.

The table up there is also used for SANITY checks. So even if Linux doesn't use
the fields directly, the sanity checks could run on the fields and report issues which
might be problematic for the normal operation (if at all any).

Also since you are adding the information about the new register to the table,
its good to have the fields defined along with this patch to make the UAO patch
a bit more cleaner, which would make use of it eventually.


Cheers
Suzuki

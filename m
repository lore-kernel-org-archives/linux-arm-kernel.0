From: prarit@redhat.com (Prarit Bhargava)
Date: Tue, 23 Jan 2018 07:41:56 -0500
Subject: [PATCH] acpi, spcr: Make SPCR available to x86
In-Reply-To: <745c9e29-f0b4-775b-28f7-8712cdc90fe1@codeaurora.org>
References: <20180118150951.28964-1-prarit@redhat.com>
 <745c9e29-f0b4-775b-28f7-8712cdc90fe1@codeaurora.org>
Message-ID: <5fab980d-d937-8806-9745-9850947a9096@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/22/2018 04:49 PM, Timur Tabi wrote:
> On 01/18/2018 09:09 AM, Prarit Bhargava wrote:
>>       if (acpi_disabled) {
>> -        if (earlycon_init_is_deferred)
>> +        if (earlycon_acpi_spcr_enable)
> 
> This patch works for me, so I can ACK it, but first you might want to rename
> earlycon_acpi_spcr_enable, because these two lines don't make much sense.
> 
> "If ACPI is disabled, and ACPI SCPR is enabled, then ...."
> 
> If ACPI is disabled, then how can a variable called "earlycon_acpi_spcr_enable"
> be true?
> 
> Would it make more sense to rename it to earlycon_spcr_enable?
> 

acpi_disabled is a global runtime flag that can be set via "acpi=off" on the
command line.  It does not disable the tables, only the reading and interpreting
of the data in the tables.

P.

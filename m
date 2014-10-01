From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Wed, 1 Oct 2014 16:19:37 -0500
Subject: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
In-Reply-To: <20140917012614.GA31214@srcf.ucam.org>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1410828446-28502-2-git-send-email-suravee.suthikulpanit@amd.com>
 <20140917012614.GA31214@srcf.ucam.org>
Message-ID: <542C6FE9.10903@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/16/2014 8:26 PM, Matthew Garrett wrote:
> On Mon, Sep 15, 2014 at 07:47:23PM -0500, suravee.suthikulpanit at amd.com wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> This patch adds ACPI match table in ahci_platform. The table includes
>> the acpi_device_id to match AMD Seattle SATA controller with following
>> asl structure in DSDT:
>>
>>      Device (SATA0)
>>      {
>>        Name(_HID, "AMDI0600")	// Seattle AHSATA
>
> There really ought to be a well-defined PNPID for AHCI, so you can _HID
> to AMD and _CID to something generic. That way we won't have:
>
>> +#ifdef CONFIG_ATA_ACPI
>> +static const struct acpi_device_id ahci_acpi_match[] = {
>> +	{ "AMDI0600", 0 }, /* AMD Seattle AHCI */
>> +	{ },
>> +};
>
> utter sadness here. Really, please don't end up in a situation where we
> need to add device-specific IDs to a generic driver.
>
Matthew,

Currently, there is no _CID defined for generic AHCI. We will work on 
proposing one, and provide update patches for including the new ID.

Thanks,
Suravee

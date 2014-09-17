From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Wed, 17 Sep 2014 02:26:14 +0100
Subject: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
In-Reply-To: <1410828446-28502-2-git-send-email-suravee.suthikulpanit@amd.com>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1410828446-28502-2-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20140917012614.GA31214@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 07:47:23PM -0500, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch adds ACPI match table in ahci_platform. The table includes
> the acpi_device_id to match AMD Seattle SATA controller with following
> asl structure in DSDT:
> 
>     Device (SATA0)
>     {
>       Name(_HID, "AMDI0600")	// Seattle AHSATA

There really ought to be a well-defined PNPID for AHCI, so you can _HID 
to AMD and _CID to something generic. That way we won't have:

> +#ifdef CONFIG_ATA_ACPI
> +static const struct acpi_device_id ahci_acpi_match[] = {
> +	{ "AMDI0600", 0 }, /* AMD Seattle AHCI */
> +	{ },
> +};

utter sadness here. Really, please don't end up in a situation where we 
need to add device-specific IDs to a generic driver.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org

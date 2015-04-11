From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 16:50:47 +0200
Subject: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
In-Reply-To: <CAL85gmDmycodMV2WJydmA7u60S+K2w3Ji=BSVPfAg04N6unX0g@mail.gmail.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
 <55280665.9020603@arm.com>
 <CAL85gmDmycodMV2WJydmA7u60S+K2w3Ji=BSVPfAg04N6unX0g@mail.gmail.com>
Message-ID: <8653876.C24YDfhd04@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 April 2015 17:16:32 Feng Kan wrote:
> Hi Marc:
> 
> Is there any plans to support ACPI for GICv2m MSI? Both this driver and the
> GICv2m seems to support OF model of discovery for msi controller. X-Gene1
> uses this driver and X-Gene2 uses GICv2m, there needs to be a way to
> associate msi controller with the PCIe bus. I haven't
> found a standard way of doing finding "msi-parent" for ACPI. Do you have
> any suggestion.
> 
> Sorry for top posting.

Doing gicv2m in ACPI should be straightforward, and the ACPI code can simply
assume that there is only one GIC instance (whichever version) in the system
and use that for all standard PCI hosts.

	Arnd

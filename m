From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Apr 2015 13:18:43 +0100
Subject: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
In-Reply-To: <CAL85gmDmycodMV2WJydmA7u60S+K2w3Ji=BSVPfAg04N6unX0g@mail.gmail.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
 <cover.1428564115.git.dhdang@apm.com>
 <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
 <55280665.9020603@arm.com>
 <CAL85gmDmycodMV2WJydmA7u60S+K2w3Ji=BSVPfAg04N6unX0g@mail.gmail.com>
Message-ID: <bb00880b6d37fff304797d0c3e4e670d@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Feng,

On 2015-04-11 01:16, Feng Kan wrote:

> Is there any plans to support ACPI for GICv2m MSI? Both this driver 
> and the
> GICv2m seems to support OF model of discovery for msi controller. 
> X-Gene1
> uses this driver and X-Gene2 uses GICv2m, there needs to be a way to
> associate msi controller with the PCIe bus. I haven't
> found a standard way of doing finding "msi-parent" for ACPI. Do you 
> have
> any suggestion.

This is remarkably off topic! ;-)

ACPI only provides information for GICv2m and GICv3. No other interrupt 
controller,
MSI widget or fairy dust provider will be supported on arm64 with ACPI. 
So this driver
will be DT only.

GICv2m, being described in the ACPI spec, is growing some support. My 
understanding is
that this is done by AMD (Suravee Suthikulpanit) using my 
irq/msi-domain branch as a
base (I know that Suravee is looking at expanding the irqdomain 
matching code to
accept a pointer to an ACPI table instead of a device node to match the 
target
domain).

Hope this helps,

         M.
-- 
Fast, cheap, reliable. Pick two.

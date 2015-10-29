From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 29 Oct 2015 12:38:32 +0100
Subject: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
In-Reply-To: <563131B0.9060305@codeaurora.org>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <563131B0.9060305@codeaurora.org>
Message-ID: <56320538.6000905@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.10.2015 21:36, Sinan Kaya wrote:
> 1. ACPI code is unable to discover the interrupt numbers when objects
> are ordered as follows in the ACPI file
>
> PNP0A08 object
> PNP0C0F INTA object
> PNP0C0F INTB object
> PNP0C0F INTC object
> PNP0C0F INTD object
>
> This gives me invalid link context error.
>
> pci 0000:00:00.0: PCI INT A: no GSI
> pci 0000:01:00.0: Derived GSI for 0000:01:00.0 INT A from 0000:00:00.0
> acpi PNP0C0F:00: Invalid link context
>
> If I order it like this in the ACPI file,
>
> PNP0C0F INTA object
> PNP0C0F INTB object
> PNP0C0F INTC object
> PNP0C0F INTD object
> PNP0A08 object
>
> then, the legacy interrupt numbers can be discovered properly.

Can you show full content of your PNP0C0F and PNP0A08 objects?

Regards,
Tomasz

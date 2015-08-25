From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Aug 2015 20:48:24 +0200
Subject: [PATCH V2 0/4] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
In-Reply-To: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <240091906.Gl2z931jjW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 August 2015 00:33:25 Suravee Suthikulpanit wrote:
> This patch adds support to setup DMA coherency for PCI device using
> the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
> is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
> support for ARM64 which is currently in development.
> 
> Also, this should not affect other architectures that does not define 
> CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.
> 

We only support ACPI on SBSA compliant platforms, and SBSA mandates
cache-coherent PCI, so I don't think this is actually needed,
just use coherent all the time and do WARN_ON(!CCA) to catch people
that try to incorrectly use ACPI on a non-SBSA platform.

	Arnd

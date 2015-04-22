From: jcm@redhat.com (Jon Masters)
Date: Tue, 21 Apr 2015 23:02:38 -0400
Subject: [PATCH v5 0/4]PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination
 driver
In-Reply-To: <cover.1429586144.git.dhdang@apm.com>
References: <55310050.7000003@arm.com> <cover.1429586144.git.dhdang@apm.com>
Message-ID: <55370F4E.6020604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 12:04 AM, Duc Dang wrote:
> This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
> APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
> to GIC V2M specification for MSI Termination.
> 
> There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
> block supports 2048 MSI termination ports coalesced into 16 physical HW IRQ lines
> and shared across all 5 PCIe ports. As the version 5 of this patch, the total MSI
> vectors this driver supports is reduced to 256 to maintain the correct set_affinity 
> behavior for each MSI.

Quick note that I have tested the previous several versions of this
patch series on several platforms and will test v6 once available with
the pending feedback addressed.

Jon.

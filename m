From: jgross@suse.com (Juergen Gross)
Date: Wed, 22 Nov 2017 13:53:58 +0100
Subject: [PATCH 21/30] xen: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-22-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-22-git-send-email-okaya@codeaurora.org>
Message-ID: <780202b1-3819-6e0f-10e8-059235845799@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/17 06:31, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

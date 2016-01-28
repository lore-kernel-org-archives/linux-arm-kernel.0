From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Jan 2016 16:24:28 +0000
Subject: [PATCH v2 2/6] irqchip: irq-armada-370-xp: use the generic MSI
 infrastructure
In-Reply-To: <1453899395-3532-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1453899395-3532-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453899395-3532-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <56AA40BC.3060300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/16 12:56, Thomas Petazzoni wrote:
> This commit moves the irq-armada-370-xp driver from using the
> PCI-specific MSI infrastructure to the generic MSI infrastructure, to
> which drivers are progressively converted.
> 
> In this hardware, the MSI controller is directly bundled inside the
> interrupt controller, so we have a single Device Tree node to which
> multiple IRQ domaines are attached: the wired interrupt domain and the
> MSI interrupt domain. In order to ensure that they can be
> differentiated, we have to force the bus_token of the wired interrupt
> domain to be DOMAIN_BUS_WIRED. The MSI domain bus_token is
> automatically set to the appropriate value by
> pci_msi_create_irq_domain().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

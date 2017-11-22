From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 22 Nov 2017 00:08:45 -0600
Subject: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
In-Reply-To: <6a78596e-720a-80a2-9d96-dcc79a32f677@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
 <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
 <6a78596e-720a-80a2-9d96-dcc79a32f677@codeaurora.org>
Message-ID: <25ec431a-2c1b-d352-f9ef-c663864664b6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/17 11:55 PM, Sinan Kaya wrote:
> For places where domain number information is available, I extracted domain number
> and added into pci_get_domain_bus_and_slot() call such as xen or bn drivers.

My suggestion is that you restrict your first patch set to only these 
patches.

> The assumption at this point is for pci_get_bus_and_slot() usages to be caught
> in code-review.

How about this:

static inline struct pci_dev * __deprecated 
pci_get_bus_and_slot(unsigned int bus,
						   unsigned int devfn)
{
	return pci_get_domain_bus_and_slot(0, bus, devfn);
}


-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 21 Nov 2017 23:45:37 -0600
Subject: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
In-Reply-To: <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
Message-ID: <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/17 11:31 PM, Sinan Kaya wrote:
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Now that all users of pci_get_bus_and_slot() switched to
> pci_get_domain_bus_and_slot(), it is now safe to remove this function.

This doesn't really eliminate pci_get_bus_and_slot(), because it doesn't 
force developers to support non-zero domains.  What's to stop a driver 
developer from doing this?

#define pci_get_bus_and_slot(b, d) pci_get_domain_bus_and_slot(0, b, d)

thereby completely ignoring what you're trying to do?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

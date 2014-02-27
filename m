From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 14:22:13 +0100
Subject: [PATCH v2 2/4] pci: Create pci_host_bridge before its associated
 bus in pci_create_root_bus.
In-Reply-To: <1393506402-11474-3-git-send-email-Liviu.Dudau@arm.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506402-11474-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <6845675.ZDsMtaSPuS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 13:06:40 Liviu Dudau wrote:
> Before commit 7b5436635800 the pci_host_bridge was created before the root bus.
> As that commit has added a needless dependency on the bus for pci_alloc_host_bridge()
> the creation order has been changed for no good reason. Revert the order of
> creation as we are going to depend on the pci_host_bridge structure to retrieve the
> domain number of the root bus.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 

Looks good to me.

	Arnd

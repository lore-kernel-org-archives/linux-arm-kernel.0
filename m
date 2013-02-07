From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Feb 2013 17:40:40 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130207171904.70270598@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com> <20130207153750.0fef1192@skate>
 <20130207155117.GA19666@arm.com> <20130207171904.70270598@skate>
Message-ID: <20130207174040.3a345770@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thomas Petazzoni,

On Thu, 7 Feb 2013 17:19:04 +0100, Thomas Petazzoni wrote:

> Unfortunately, I don't quite agree with any of your three solutions. I
> still do believe the root problem is that pdev->dev.of_node should be
> NULL for the PCIe endpoints, since those devices are not probed with
> the Device Tree.

Looking more at this, the pdev->dev.of_node is in fact NULL, but the
code uses the of_node of the parent PCI device.

So in fact the problem is indeed that the subnodes pcie0,0 and pcie1,0
are seen as corresponding to the PCI-to-PCI bridges.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

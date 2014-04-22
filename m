From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 22 Apr 2014 11:56:05 -0600
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140418145847.709b29ce@skate>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
 <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
 <20140418145847.709b29ce@skate>
Message-ID: <20140422175605.GE23955@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> mvebu-pcie pcie-controller.2: PCIe0.0: performing link reset
> mvebu-pcie pcie-controller.2: PCIe0.0: link went down after 20 tries
> mvebu-pcie pcie-controller.2: PCIe0.0: link came back up after 100 tries

So the '100' here says the timeout expired. My first stab would be to
set the timeout longer.. Maybe your chip takes longer to train the
link.

You also mentioned that setting Conf_TrainingDisable doesn't cause the
link to go down? That would be useful to verify (in a clean
environment without clock gating weirdness..)

> # /usr/sbin/lspci 
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710

I'm guessing:

echo 1 > /sys/bus/pci/rescan

Will make it appear?

Jason

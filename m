From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 16 Jul 2018 16:06:06 +0100
Subject: [PATCH 0/8] Fix PCI I/O space page leaks
In-Reply-To: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
References: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
Message-ID: <20180716150606.GA19945@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2018 at 07:00:21PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> Here's a set of 8 patches against the 'pci/controller-fixes' branch of Lorenzo
> Pieralisi's 'pci.git' repo. They are the fixes for the PCI I/O space page leaks
> (and the kernel BUG caused by them on deferred probe); those were 1st found
> testing the R-Car PCIe driver. The patches are in the chronological order
> (considering the date/time of the commits specified in the Fixes: tag), patches
> #2..#8 depend on the patch #1 in order to build/work as it introduces the managed
> device API that they all use...
> 
> [1/8] PCI: xgene: Fix I/O space page leak
> [2/8] PCI: of: Fix I/O space page leak
> [3/8] PCI: versatile: Fix I/O space page leak
> [4/8] PCI: designware: Fix I/O space page leak
> [5/8] PCI: aardvark: Fix I/O space page leak
> [6/8] PCI: faraday: Fix I/O space page leak
> [7/8] PCI: mediatek: Fix I/O space page leak
> [8/8] PCI: v3-semi: Fix I/O space page leak
> 
> MBR, Sergei

Hi Sergei,

I reshuffled the series, rewrote commit logs and move the devm_
API to commit 2 which is the one you tested AFAIK.

I pushed them out to my pci/controller-fixes branch which I hope
we can still aim for an -rc, please do have a look and let me know
what you think, I have not asked Bjorn to pull it yet.

Thanks,
Lorenzo

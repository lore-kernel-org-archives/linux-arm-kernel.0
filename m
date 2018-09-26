From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 26 Sep 2018 11:45:27 +0100
Subject: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
In-Reply-To: <20180925201619.GB8413@lst.de>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net>
 <20180925201619.GB8413@lst.de>
Message-ID: <fe8bae9a-10d1-ca88-158d-5caf9aa80885@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/18 21:16, Christoph Hellwig wrote:
> Looking at the code I think this commit is simply broken for
> architectures not using arch_setup_dma_ops, but instead setting up
> the dma ops through arch specific magic.
> 
> I'll revert the patch.

Ugh, sorry about missing that too. Ack to a revert - thinking about 
those PPC symptoms, it might actually be that other architectures could 
also get into the same pickle just by unbinding and rebinding a driver 
(e.g. switching to VFIO then back again).

Robin.

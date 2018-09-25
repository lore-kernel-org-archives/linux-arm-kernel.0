From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Sep 2018 22:16:19 +0200
Subject: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
In-Reply-To: <20180922150119.GA14761@roeck-us.net>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net>
Message-ID: <20180925201619.GB8413@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looking at the code I think this commit is simply broken for
architectures not using arch_setup_dma_ops, but instead setting up
the dma ops through arch specific magic.

I'll revert the patch.

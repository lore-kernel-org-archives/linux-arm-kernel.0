From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Oct 2017 10:14:22 +0200
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <589c04cb-061b-a453-3188-79324a02388e@arm.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
Message-ID: <20171017081422.GA19475@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just took a quick look over this and I basically agree with the comments
from Robin.

What I don't understand is why you're even trying to do all these
hacky things.

It seems like the controller should simply set dma_pfn_offset for
each device hanging off it, and all the supported architectures
should be updated to obey that if they don't do so yet, and
you're done without needing this giant mess.

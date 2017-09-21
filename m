From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 21 Sep 2017 22:51:26 +0530
Subject: [PATCH v2] dmaengine: edma: Align the memcpy acnt array size
 with the transfer
In-Reply-To: <20170918081626.12878-1-peter.ujfalusi@ti.com>
References: <20170918081626.12878-1-peter.ujfalusi@ti.com>
Message-ID: <20170921172126.GJ30097@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 11:16:26AM +0300, Peter Ujfalusi wrote:
> Memory to Memory transfers does not have any special alignment needs
> regarding to acnt array size, but if one of the areas are in memory mapped
> regions (like PCIe memory), we need to make sure that the acnt array size
> is aligned with the mem copy parameters.
> 
> Before "dmaengine: edma: Optimize memcpy operation" change the memcpy was set
> up in a different way: acnt == number of bytes in a word based on
> __ffs((src | dest | len), bcnt and ccnt for looping the necessary number of
> words to comlete the trasnfer.
> 
> Instead of reverting the commit we can fix it to make sure that the ACNT size
> is aligned to the traswnfer.

Applied, thanks

-- 
~Vinod

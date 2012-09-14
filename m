From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 14:26:40 +0530
Subject: [PATCH] mxs/dma: Enlarge the CCW descriptor area to 4 pages
In-Reply-To: <20120914083050.GA12245@n2100.arm.linux.org.uk>
References: <1346731465-6301-1-git-send-email-marex@denx.de>
 <20120905014000.GP2362@S2101-09.ap.freescale.net>
 <201209050346.39253.marex@denx.de> <1347591975.1943.12.camel@vkoul-udesk3>
 <20120914083050.GA12245@n2100.arm.linux.org.uk>
Message-ID: <1347613000.1943.34.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 09:30 +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 14, 2012 at 08:36:15AM +0530, Vinod Koul wrote:
> > On Wed, 2012-09-05 at 03:46 +0200, Marek Vasut wrote:
> > > One way to fix this is to recycle descriptors that were already used during the 
> > > transfer, but can we really do it fast enough, so the DMA would do it's job at 
> > > one end of the descriptor chain and we'd be building the other?
> > See the comment in dma_ctrl_flags:
> > * @DMA_CTRL_ACK - if clear, the descriptor cannot be reused until the client
> > *  acknowledges receipt, i.e. has has a chance to establish any dependency
> > *  chains
> > Setting this would mean that driver can reuse the descriptor once the
> > transaction has completed.
> 
> Actually, that has little meaning for slave DMA descriptors (other than
> it should already be set for consistency with the async_tx stuff, which
> has the above mentioned depenedency chains.)
> 
> Once completed, descriptors can be reused irrespective of the above flag.
Yes that is the reason no one in slave world uses it and we consider the
descriptor can be reused once transaction is complete.
FWIW I see some of the salve drivers do consider this flag!!


-- 
~Vinod

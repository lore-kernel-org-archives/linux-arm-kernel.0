From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 18:49:51 +0100
Subject: [PATCH] DMA: mv_xor: Add a device_control function
In-Reply-To: <1353172501-499-1-git-send-email-andrew@lunn.ch>
References: <1353172501-499-1-git-send-email-andrew@lunn.ch>
Message-ID: <20121117174951.GB14372@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2012 at 06:15:01PM +0100, Andrew Lunn wrote:
> The dmatest module for DMA engines calls
> 
> device_control(dtc->chan, DMA_TERMINATE_ALL, 0);
> 
> after completing the tests. The documentation in
> include/linux/dmaengine.h suggests this function is optional and
> dma_async_device_register() also does not BUG_ON() when not passed a
> function. However, dmatest is not the only code in the kernel
> unconditionally calling device_control. So add an implementation
> indicating all operations are not implemented.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Arg!

Sorry, please ignore this version. I should not be removing length checks.

       Andrew

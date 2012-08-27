From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 27 Aug 2012 09:52:42 -0700
Subject: [PATCH] dma: imx-dma: Fix kernel crash due to missing clock
 conversion
In-Reply-To: <20120827163006.0cffd20c@eb-e6520>
References: <1341341045-9472-1-git-send-email-fabio.estevam@freescale.com>
 <20120827163006.0cffd20c@eb-e6520>
Message-ID: <20120827165242.GA11102@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 04:30:06PM +0200, Eric B?nard wrote:
> Hi Greg, Hi Fabio,
> 
> this patch went into 3.4.10 as commit
> 9ea2c02bafe276e97b592a046ac733610a6d57fd
> which seems wrong as devm_clk_get seems to be added in linux-3.5 so
> compiling a 3.4.10 kernel with imx-dma enabled now leads :
> 
> drivers/dma/imx-dma.c: In function 'imxdma_probe':
> drivers/dma/imx-dma.c:980: error: implicit declaration of function
> 'devm_clk_get'
> drivers/dma/imx-dma.c:980: warning: assignment makes pointer from
> integer without a cast
> drivers/dma/imx-dma.c:986: warning: assignment makes pointer from
> integer without a cast
> 
> Reverting 9ea2c02bafe276e97b592a046ac733610a6d57fd allows to get a
> 3.4.10 kernel running fine on an i.MX35.

Ok, should I just revert it?  It's still needed on 3.5, right?

greg k-h

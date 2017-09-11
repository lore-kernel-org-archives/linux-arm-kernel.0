From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Sep 2017 11:52:28 +0530
Subject: [PATCH RFC] davinci: da850: define edma-memcpy-channels
In-Reply-To: <1504960117-24264-1-git-send-email-aford173@gmail.com>
References: <1504960117-24264-1-git-send-email-aford173@gmail.com>
Message-ID: <54b0fb00-0337-522a-d66a-6506f60a3679@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Saturday 09 September 2017 05:58 PM, Adam Ford wrote:
> When booting with a device tree, message appears:
>    memcpy is disabled
> When reading through the bindings for eDMA3, it shows that
> ti,edma-memcpy-channels is an optional property, but the example
> binding uses it.
> 
> RFC:  I'll be the first to admit that I don't understand what
> this is doing, but it seems like a DMA enabled memcpy would
> improve performance.  Is this appropriate for da850?  Since there
> are two eDMA3-tpcc controllers, is there a set of channels we can
> use for each?
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

This enables DMA-based memcpy (see drivers/dma/dmaetest.c for example).
But does not accelerate any memcpy in kernel automatically.

If this is done, it should be done in a board specific manner because
the available channels you pick up for memcpy support can change from
board to board.

Thanks,
Sekhar

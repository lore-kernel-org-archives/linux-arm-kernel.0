From: davem@davemloft.net (David Miller)
Date: Thu, 09 Dec 2010 12:00:06 -0800 (PST)
Subject: [RFC PATCH] scatterlist: Initialize the dma_address field with
	invalid dma address
In-Reply-To: <1291900514-7290-1-git-send-email-nicolas.ferre@atmel.com>
References: <1291900514-7290-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20101209.120006.189701386.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu,  9 Dec 2010 14:15:14 +0100

> Initialize the the dma_address field so that it will be possible to test
> its value while using scatterlists. This field will be compatible with
> testing by dma_mapping_error().
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Please don't do this, it's unjustified and it's going to kill performance.
Even if it were a good change, you should have used the invalid DMA
address definition defined by various architectures instead of a constant.

You should be aware of whether entries in a scatterlist have been setup
by your code path.

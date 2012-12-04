From: davem@davemloft.net (David Miller)
Date: Tue, 04 Dec 2012 13:22:27 -0500 (EST)
Subject: [PATCH] net/macb: increase RX buffer size for GEM
In-Reply-To: <1354536943-6356-1-git-send-email-nicolas.ferre@atmel.com>
References: <1354536943-6356-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20121204.132227.1430662061932892582.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 3 Dec 2012 13:15:43 +0100

> Macb Ethernet controller requires a RX buffer of 128 bytes. It is
> highly sub-optimal for Gigabit-capable GEM that is able to use
> a bigger DMA buffer. Change this constant and associated macros
> with data stored in the private structure.
> I also kept the result of buffers per page calculation to lower the
> impact of this move to a variable rx buffer size on rx hot path.
> RX DMA buffer size has to be multiple of 64 bytes as indicated in
> DMA Configuration Register specification.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

This looks like it will waste a couple hundred bytes for 1500 MTU
frames, am I right?

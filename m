From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Nov 2015 21:06:34 +0100
Subject: [PATCH 00/13] mvneta Buffer Management and enhancements
In-Reply-To: <1448178839-3541-1-git-send-email-mw@semihalf.com>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
Message-ID: <12984648.7CKVgBs7pu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 November 2015 08:53:46 Marcin Wojtas wrote:
> 
> 3. Optimisations - concatenating TX descriptors' flush, basing on
> xmit_more support and combined approach for finalizing egress processing.
> Thanks to HR timer buffers can be released with small latency, which is
> good for low transfer and small queues. Along with the timer, coalescing
> irqs are used, whose threshold could be increased back to 15.
> 
> 

If you are already reworking the TX path, it probably makes sense to 
support BQL as well, see the Marvell skge and sky2 drivers for examples
using netdev_{tx_,}{sent,completed}_queue.

	Arnd

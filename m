From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Mon, 7 Dec 2009 11:37:21 -0800 (PST)
Subject: non barrier versions of dma_map functions
Message-ID: <7f6a66b765002fcc815937b5d8d085cf.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a situation where we need to dma map multiple cached buffers for a
single dma transaction.

The current DMA api suggests the use of dma_map_single for cache
consistency. On ARMv7 it performs the necessary cache-operations and calls
data sync barrier instruction (DSB). In our case we would be executing
multiple DSB instruction before starting the dma operation - we need
memory to be consistent only after we map the last buffer.

I am thinking we could define "no barrier" version's of all the mapping
functions and then a barrier function that results in DSB before the dma
is started.

Requesting alternative ideas or code design to get the desired nonbarrier
versions of the mapping functions.

Abhijeet Dharmapurikar

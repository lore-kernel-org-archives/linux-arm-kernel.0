From: davem@davemloft.net (David Miller)
Date: Mon, 15 Apr 2013 14:08:37 -0400 (EDT)
Subject: net: mvneta: fix improper tx queue usage in mvneta_tx()
In-Reply-To: <20130415063537.GA26507@1wt.eu>
References: <20130415063537.GA26507@1wt.eu>
Message-ID: <20130415.140837.1962205759703539734.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Willy Tarreau <w@1wt.eu>
Date: Mon, 15 Apr 2013 08:35:37 +0200

> From 4f2069c92a27790e6071dc2a80f92c166e0b0ca4 Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Thu, 11 Apr 2013 23:00:37 +0200
> Subject: net: mvneta: fix improper tx queue usage in mvneta_tx()
> 
> mvneta_tx() was using a static tx queue number causing crashes as
> soon as a little bit of traffic was sent via the interface, because
> it is normally expected that the same queue should be used as in
> dev_queue_xmit().
> 
> As suggested by Ben Hutchings, let's use skb_get_queue_mapping() to
> get the proper Tx queue number, and use alloc_etherdev_mqs() instead
> of alloc_etherdev_mq() to create the queues.
> 
> Both my Mirabox and my OpenBlocks AX3 used to crash without this patch
> and don't anymore with it. The issue appeared in 3.8 but became more
> visible after the fix allowing GSO to be enabled.
> 
> Original work was done by Dmitri Epshtein and Thomas Petazzoni. I
> just adapted it to take care of Ben's comments.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Applied.

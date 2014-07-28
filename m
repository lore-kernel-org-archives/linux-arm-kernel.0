From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 28 Jul 2014 05:24:34 +0000 (UTC)
Subject: [PATCH] arm: omap: hwmod: drop unnecessary list initialization
In-Reply-To: <1405455492-1087-1-git-send-email-balbi@ti.com>
References: <1405455492-1087-1-git-send-email-balbi@ti.com>
Message-ID: <alpine.DEB.2.02.1407280524160.24161@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jul 2014, Felipe Balbi wrote:

> ml->node and sl->node are currently initialized
> by means of INIT_LIST_HEAD(). That initialiation
> is followed by a list_add() call.
> 
> Looking at what both these functions do we will have:
> 
> 	ml->node.next = &ml->node;
> 	ml->node.prev = &ml->node;
> 	oi->master->master_ports.next.prev = &ml->node;
> 	ml->node.next = &oi->master->master_ports.next;
> 	ml->node.prev = &oi->master->master_ports;
> 	oi->master->master_ports.next = &ml->node;
> 
> from this, it's clear that both INIT_LIST_HEAD() calls
> are unnecessary and can be safely removed.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> found by code inspection, boot tested on am437x SK on today's
> linux-next + pending patches.

Thanks, queued for v3.18.

- Paul

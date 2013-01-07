From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 11:44:15 -0500
Subject: [PATCH 3.8-rc] net: mvneta: fix driver operation in SMP context
In-Reply-To: <1357576074-24245-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576074-24245-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130107164415.GI5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 05:27:54PM +0100, Thomas Petazzoni wrote:
> From: Dmitri Epshtein <dima@marvell.com>
> 
> In order for the driver to behave properly in a SMP context, the same
> transmit queue should be used by the kernel in dev_queue_xmit() and in
> the driver's mvneta_tx() function. To achieve that, the driver now
> implements the ->ndo_select_txq() operation.
> 
> For now, it always returns the same transmit queue, txq_def, until the
> driver is expanded to properly take advantage of the multiqueue
> capabilities of the hardware.
> 
> Without this patch, the network driver crashes the kernel almost
> immediately on Armada XP platforms, if the network load is at least a
> little bit parallel (i.e several threads).
> 
> [Thomas Petazzoni: reword commit message]
> Signed-off-by: Dmitri Epshtein <dima@marvell.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

I'll assume this is going through -net, let me know if it should be
otherwise.

thx,

Jason.

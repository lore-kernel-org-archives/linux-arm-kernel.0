From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 23 Nov 2011 12:18:16 +0100
Subject: [PATCH] IMX/SDMA : save the real count for one DMA transaction.
In-Reply-To: <4ECCD553.5020804@freescale.com>
References: <1322039585-7901-1-git-send-email-b32955@freescale.com>
 <20111123105821.GC4063@pengutronix.de>
 <4ECCD34C.1090400@freescale.com>
 <20111123110626.GD4063@pengutronix.de>
 <4ECCD553.5020804@freescale.com>
Message-ID: <20111123111816.GF4063@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 07:13:23PM +0800, Huang Shijie wrote:
> 
> >>>> +	/* save the real count we received or transmitted. */
> >>>> +	chan->private = (void *)count;
> >>> And if someone later needs another variable which is private?
> >>>
> >> I ever wanted to add an new parameter `void *` to dma_aync_tx_callback,
> >> but it seemed i have
> >> to change a lot of files.
> >>
> >> Do you have any better suggestion?
> > Use a private struct and put count in there.
> >
> Where to put the private struct? in the imx-sdma.c ?
> If i put it there, how can i get it in the UART driver with the current
> DMA API?

So, in the UART driver you assume that void* is an int? Or how do you
currently use count?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/ad9bf81d/attachment.sig>

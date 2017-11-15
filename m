From: eric@anholt.net (Eric Anholt)
Date: Wed, 15 Nov 2017 10:53:57 -0800
Subject: [PATCH 05/10] dmaengine: bcm2835-dma: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <20171114143212.8311-6-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
 <20171114143212.8311-6-peter.ujfalusi@ti.com>
Message-ID: <87k1yr4blm.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> To avoid race with vchan_complete, use the race free way to terminate
> running transfer.
>
> Implement the device_synchronize callback to make sure that the terminated
> descriptor is freed.
>
> CC: Martin Sperl <kernel@martin.sperl.org>
> CC: Eric Anholt <eric@anholt.net>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I haven't fully followed the series, but thanks for porting your fix to
other platforms!

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171115/173153af/attachment.sig>

From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 11:57:34 +0100
Subject: [PATCH] i2c: omap: Move the remove constraint
In-Reply-To: <CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com>
References: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com>
 <CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com>
Message-ID: <20121114105734.GE5954@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Currently we just queue the transfer and release the
> > qos constraints, however we donot wait for the transfer
> > to complete to release the constraint. Move the remove
> > constraint after the bus busy as we are sure that the
> > transfers are completed by then.
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> Good catch, the change definitely makes sense. Feel free to add:
> 
> Acked-by: Jean Pihet <j-pihet@ti.com>

Since I just reverted the QoS patch, I suppose this gets merged into the
original patch when resent?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/8507c2cb/attachment-0001.sig>

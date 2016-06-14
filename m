From: eric@anholt.net (Eric Anholt)
Date: Mon, 13 Jun 2016 21:49:26 -0700
Subject: [PATCH 1/2] dmaengine: bcm2835: Fix cyclic DMA period splitting
In-Reply-To: <1465472504-10191-2-git-send-email-hias@horus.com>
References: <1465472504-10191-1-git-send-email-hias@horus.com>
 <1465472504-10191-2-git-send-email-hias@horus.com>
Message-ID: <87a8iowf1l.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthias Reichl <hias@horus.com> writes:

> The code responsible for splitting periods into chunks that
> can be handled by the DMA controller missed to update total_len,
> the number of bytes processed in the current period, when there
> are more chunks to follow.
>
> Therefore total_len was stuck at 0 and the code didn't work at all.
> This resulted in a wrong control block layout and audio issues because
> the cyclic DMA callback wasn't executing on period boundaries.
>
> Fix this by adding the missing total_len update.

It looks like this issue has been around for a long time, and this fix
is pretty dependent on the recent refactors.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/57a4493c/attachment.sig>

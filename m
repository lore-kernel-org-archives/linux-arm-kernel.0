From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 13 May 2016 13:50:21 +0200
Subject: [PATCH V2 2/2] drivers: i2c: qup: Fix error handling
In-Reply-To: <20160513114823.GJ1778@katana>
References: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
 <1462534274-28925-3-git-send-email-sricharan@codeaurora.org>
 <20160513114823.GJ1778@katana>
Message-ID: <20160513115021.GK1778@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 01:48:23PM +0200, Wolfram Sang wrote:
> On Fri, May 06, 2016 at 05:01:14PM +0530, Sricharan R wrote:
> > Among the bus errors reported from the QUP_MASTER_STATUS register
> > only NACK is considered and transfer gets suspended, while
> > other errors are ignored. Correct this and suspend the transfer
> > for other errors as well. This avoids unnessecary 'timeouts' which
> > happens when waiting for events that would never happen when there
> > is already an error condition on the bus.
> > 
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > Reviewed-by: Andy Gross <andy.gross@linaro.org>
> 
> Please check Documentation/i2c/fault-codes for proper fault codes.

And while we are here: NACK is not an error but a valid response. Can
you remove the dev_err related to that? Otherwise tools like i2cdetect
will probably flood your log.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160513/9cb5f28c/attachment.sig>

From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 18 Jun 2016 18:25:48 +0200
Subject: [PATCH V4 3/3] i2c: qup: Fix error handling
In-Reply-To: <1465582101-19391-4-git-send-email-sricharan@codeaurora.org>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-4-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160618162548.GD3017@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 11:38:21PM +0530, Sricharan R wrote:
> Among the bus errors reported from the QUP_MASTER_STATUS register
> only NACK is considered and transfer gets suspended, while
> other errors are ignored. Correct this and suspend the transfer
> for other errors as well. This avoids unnecessary 'timeouts' which
> happens when waiting for events that would never happen when there
> is already an error condition on the bus. Also the error handling
> procedure should be the same for both NACK and other bus errors in
> case of dma mode. So correct that as well.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/29d4ec80/attachment.sig>

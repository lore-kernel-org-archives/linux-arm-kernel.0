From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Mar 2017 19:35:30 +0000
Subject: [PATCH v3 3/6] spi: davinci: use rx buffer as dummy tx buffer
In-Reply-To: <1487872921-26628-4-git-send-email-fisaksen@baylibre.com>
References: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
 <1487872921-26628-4-git-send-email-fisaksen@baylibre.com>
Message-ID: <20170315193530.fjguqfb6vjd7kfey@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 07:01:58PM +0100, Frode Isaksen wrote:
> When doing rx-only transfer, the transfer will fail
> if the number of SG entries exceeds 20.
> This happens because the eDMA DMA engine is limited
> to 20 SG entries in one transaction, and when the
> DMA transcation is resumed (which takes > 150us),
> rx errors occurs because the slave is still transmitting.
> Fix this by using the rx buffer as the dummy tx buffer,
> so that resuming the rx transcation happens at the same
> time as resuming the tx transcation.

Please submit a followup patch adding a comment explaing what's going
in the actual code as someone's going to clean this up at some point.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/2cfc400d/attachment.sig>

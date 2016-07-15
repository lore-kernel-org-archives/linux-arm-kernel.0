From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 15 Jul 2016 15:33:18 +0900
Subject: [PATCH 1/2] i2c: qup: Cleared the error bits in ISR
In-Reply-To: <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
Message-ID: <20160715063317.GB7675@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 06:14:30PM +0530, Abhishek Sahu wrote:
> 1. Current QCOM I2C driver hangs when sending data to address 0x03-0x07
> in some scenarios. The QUP controller generates invalid write in this
> case, since these addresses are reserved for different bus formats.
> 
> 2. Also, the error handling is done by I2C QUP ISR in the case of DMA
> mode. The state need to be RESET in case of any error for clearing the
> available data in FIFO, which otherwise leaves the BAM DMA controller
> in hang state.
> 
> This patch fixes the above two issues by clearing the error bits from
> I2C and QUP status in ISR in case of I2C error, QUP error and resets
> the QUP state to clear the FIFO data.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/091568a5/attachment.sig>

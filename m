From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 15 Jul 2016 15:38:07 +0900
Subject: [PATCH 2/2] i2c: qup: Fixed the DMA segments length
In-Reply-To: <1462797871-8595-3-git-send-email-absahu@codeaurora.org>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-3-git-send-email-absahu@codeaurora.org>
Message-ID: <20160715063806.GC7675@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 06:14:31PM +0530, Abhishek Sahu wrote:
> 1. The current QCOM I2C driver code is failing for transfer length
> greater than 255. This is happening due to improper segments length
> as the I2C DMA segments can be maximum of 256 bytes.
> 
> 2. The transfer length tlen was being initialized with 0 for 256
> bytes, which is being passed for DMA mappings resulting in improper
> DMA mapping length.
> 
> This patch fixes the above said problems by initializing the block
> count with the values calculated in qup_i2c_set_blk_data and calculating
> the remaining length for last DMA segment. Also, the block data length
> need to be decremented after each transfer. Additionally, this patch
> corrects the tlen assignment for DMA mapping.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/563cf6af/attachment.sig>

From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 1 Sep 2018 14:52:05 +0200
Subject: [PATCH 2/2] i2c: uniphier-f: issue STOP only for last message or
 I2C_M_STOP
In-Reply-To: <1535725848-4076-2-git-send-email-yamada.masahiro@socionext.com>
References: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
 <1535725848-4076-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20180901125205.GE1196@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 11:30:48PM +0900, Masahiro Yamada wrote:
> This driver currently emits a STOP if the next message is not
> I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
> ioctl, where read/write transactions are combined without STOP
> between.
> 
> Issue STOP only when the message is the last one _or_ flagged with
> I2C_M_STOP.
> 
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180901/e303d2b8/attachment.sig>

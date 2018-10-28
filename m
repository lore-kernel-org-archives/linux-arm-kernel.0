From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 28 Oct 2018 22:08:03 +0000
Subject: [PATCH 3/3] i2c: uniphier-f: fix race condition when IRQ is
 cleared
In-Reply-To: <1539658909-26691-4-git-send-email-yamada.masahiro@socionext.com>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
 <1539658909-26691-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20181028220803.GD1882@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 12:01:49PM +0900, Masahiro Yamada wrote:
> The current IRQ handler clears all the IRQ status bits when it bails
> out. This is dangerous because it might clear away the status bits
> that have just been set while processing the current handler. If this
> happens, the IRQ event for the latest transfer is lost forever.
> 
> The IRQ status bits must be cleared *before* the next transfer is
> kicked.
> 
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181028/dc20bb3e/attachment.sig>

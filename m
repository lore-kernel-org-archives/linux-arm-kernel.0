From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 28 Oct 2018 22:07:55 +0000
Subject: [PATCH 1/3] i2c: uniphier-f: make driver robust against
 concurrency
In-Reply-To: <1539658909-26691-2-git-send-email-yamada.masahiro@socionext.com>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
 <1539658909-26691-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20181028220755.GB1882@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 12:01:47PM +0900, Masahiro Yamada wrote:
> This is unlikely to happen, but it is possible for a CPU to enter
> the interrupt handler just after wait_for_completion_timeout() has
> expired. If this happens, the hardware is accessed from multiple
> contexts concurrently.
> 
> Disable the IRQ after wait_for_completion_timeout(), and do nothing
> from the handler when the IRQ is disabled.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181028/cc0eeae3/attachment.sig>

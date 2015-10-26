From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 26 Oct 2015 15:47:26 +0100
Subject: [PATCH v3] i2c: at91: manage unexpected RXRDY flag when starting
 a transfer
In-Reply-To: <1445852312-28389-1-git-send-email-ludovic.desroches@atmel.com>
References: <20151022130847.GE1517@katana>
 <1445852312-28389-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151026144726.GB5588@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 10:38:27AM +0100, Ludovic Desroches wrote:
> In some cases, we could start a new i2c transfer with the RXRDY flag
> set. It is not a clean state and it leads to print annoying error
> messages even if there no real issue. The cause is only having garbage
> data in the Receive Holding Register because of a weird behavior of the
> RXRDY flag.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using the DMA
> controller")
> Reported-by: Peter Rosin <peda@lysator.liu.se>
> Tested-by: Peter Rosin <peda@lysator.liu.se>
> Cc: stable at vger.kernel.org #4.1

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151026/4c8e17df/attachment.sig>

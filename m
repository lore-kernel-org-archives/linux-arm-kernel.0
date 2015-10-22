From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Oct 2015 15:08:47 +0200
Subject: [PATCH v2 2/2] i2c: at91: manage unexpected RXRDY flag when
 starting a transfer
In-Reply-To: <1445435048-25889-2-git-send-email-ludovic.desroches@atmel.com>
References: <1445435048-25889-1-git-send-email-ludovic.desroches@atmel.com>
 <1445435048-25889-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151022130847.GE1517@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 03:44:04PM +0200, Ludovic Desroches wrote:
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

    SMATCH
drivers/i2c/busses/i2c-at91.c:602 at91_do_twi_transfer warn: unused return: sr = at91_twi_read()

drivers/i2c/busses/i2c-at91.c: In function 'at91_do_twi_transfer':
drivers/i2c/busses/i2c-at91.c:550:11: warning: variable 'sr' set but not used [-Wunused-but-set-variable]
  unsigned sr;
           ^
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/5c9431d1/attachment.sig>

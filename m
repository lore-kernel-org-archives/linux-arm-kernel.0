From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Feb 2016 08:01:49 +0000
Subject: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting
 cs-gpio
In-Reply-To: <87d1s54f7f.fsf@eliezer.anholt.net>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de>
 <87d1s54f7f.fsf@eliezer.anholt.net>
Message-ID: <20160210080149.GQ13270@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 03:49:24PM -0800, Eric Anholt wrote:

> This patch surprised me.  I would have thought that the solution was to
> just write the updated CNTL bits for CPOL and wait a moment whenever it
> changes.  The CS only gets asserted later on when we get some data in
> the TX FIFO, so I think you're just reducing the chance of losing the
> race to get our inverted clock noticed by the device before the CS gets
> asserted.

We support (and generally want to use since hardware chip selects are
often very limited in what they do) chip select on GPIO.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160210/5b1f94c4/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Apr 2014 21:06:28 +0100
Subject: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
In-Reply-To: <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
Message-ID: <20140414200628.GX25182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 02:30:01PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> sometimes t->tx can be equal with t->rx. for example, spidev will make
> tx and rx point to spidev->buffer at the same time. currently, for this
> case, we map the buffer BIDIRECTION to fix the cache consistency.

I've applied this but such usage is out of spec - do we have any drivers
doing this in mainline?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/45208439/attachment.sig>

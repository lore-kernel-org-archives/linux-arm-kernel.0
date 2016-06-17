From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Jun 2016 11:47:25 +0100
Subject: [PATCH 1/5] spi: do not fail if the CS line is not connected
In-Reply-To: <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160617104725.GC26099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 04:57:21PM +0900, Andi Shyti wrote:
> Some SPI connected devices do not have any CS line connected as
> some devices are alway enabled. Indeed, until now, a common
> workaround was to assign to num_chipselect a -1 value or 255
> (num_chipselect is unsigned).
> 
> In this case do not fail and defer to the SPI device drivers the
> responsibility to check whether the num-cs is '0'.

A SPI controller always has one chip seelct, it may not be controllable
but it's at least logically present.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/ac3e4287/attachment.sig>

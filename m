From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Sep 2015 11:56:47 +0100
Subject: [PATCH 1/5] spi: introduce mmap read support for spi flash devices
In-Reply-To: <55F93F89.7060708@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <20150914183744.GF12027@sirena.org.uk> <55F93F89.7060708@ti.com>
Message-ID: <20150916105647.GK11268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 03:38:09PM +0530, Vignesh R wrote:

> But, I didn't get how to integrate with existing message queue. Memory
> mapped read by-passes message queue of SPI core. Could you please
> explain a bit more on integrating with message queue? Did you mean
> locking the existing message queue when memory mapped read is being
> requested?

Yes, and also making sure that we don't everything gets processed in
order so memory mapped requests come after any commands needed to set
them up and don't starve other work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150916/9e45d992/attachment.sig>

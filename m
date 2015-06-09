From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jun 2015 18:30:04 +0100
Subject: [PATCH v3 3/3] spi: atmel: add support to FIFOs
In-Reply-To: <bb9ae6c3a3567d4fae7689a31f771da6036661bd.1433850255.git.cyrille.pitchen@atmel.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <bb9ae6c3a3567d4fae7689a31f771da6036661bd.1433850255.git.cyrille.pitchen@atmel.com>
Message-ID: <20150609173004.GO14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 01:53:54PM +0200, Cyrille Pitchen wrote:

> To enable the FIFO feature a "atmel,fifo-size" attribute with a strictly
> positive value must be added into the node of the device-tree describing
> the spi controller.

I'd expect the driver to use FIFOs any time they make sense, I wouldn't
expect this to be something that requires configuration - I'd expect
that there's going to be at least some FIFO in all versions of the IP,
even if the size varies.  Is that not the case?

> When FIFOs are enabled, the RX one is forced to operate in SINGLE data
> mode because this driver configures the spi controller as a master. In
> master mode only, the Received Data Register has an additionnal Peripheral
> Chip Select field, which prevents us from reading more than a single data
> at each register access.
> 
> Besides, the TX FIFO operates in MULTIPLE data mode. However, even when a

This is very hard to understand as I have no idea what single and
multiple data modes are, sorry.  Please write your commit messages so
they can be read by people who aren't familiar with the internals of the
IP.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/af629ce9/attachment.sig>

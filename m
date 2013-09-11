From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 12:30:02 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <52304BFF.4060007@freescale.com>
References: <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk>
 <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk>
 <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk>
 <52304BFF.4060007@freescale.com>
Message-ID: <20130911113002.GP29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 06:54:55PM +0800, Huang Shijie wrote:

> The LUT registers needs to be filled with the SPI NOR command, such
> Fast-read/Quad-read.
> So the Quadspi driver needs to know the spi commands, and that's why the
> SPI driver has
> references to the spi command opcodes.

Indeed - what I was wondering was if those opcodes could be requested
from the flash driver rather than coded in there.  The driver needs to
write the commands to the device but it's not clear to me if it really
needs to know the specific commands.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/3401fb00/attachment.sig>

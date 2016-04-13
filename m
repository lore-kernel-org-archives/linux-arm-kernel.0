From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Apr 2016 06:59:46 +0100
Subject: [PATCH v3] spi: orion.c: Add direct access mode
In-Reply-To: <570DD967.8010703@denx.de>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk> <570CDF5F.9070106@denx.de>
 <20160412192736.GC14664@sirena.org.uk> <570DD967.8010703@denx.de>
Message-ID: <20160413055946.GH14664@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 07:30:15AM +0200, Stefan Roese wrote:
> On 12.04.2016 21:27, Mark Brown wrote:

> >Writing something in the DT won't magically configure anything in the
> >hardware which is (as I said) the bit I'm missing.

> The MBus driver (drivers/bus/mvebu-mbus.c) takes care of the MBus
> window mapping. This is done, if the board dts files has one (or
> multiple) entries for the SPI device(s) added to the 'ranges'
> property of the 'soc' node.

I'm still unclear how mapping the windows in results in connecting the
windows to the SPI block.  It also seems like we need to document what
the meaning of the reg properties of the device is, it's all very well
saying that there's a generic MBus binding but we still need to say how
the device will interpret the MBus windows that it has (assuming they
are configured to specific hardware functions transparently).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/999ec302/attachment.sig>

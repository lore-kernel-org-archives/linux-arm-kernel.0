From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Jul 2015 17:01:46 +0100
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20150715160146.GS11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 02:12:54PM +0000, Ranjit Abhimanyu Waghmode wrote:

> > > What is stacked mode?
> > > ---------------------
> > > ZynqMP GQSPI controller supports stacked mode with following
> > functionalities:
> > > 1) The Generic Quad-SPI controller also supports two SPI flash memories
> > >    in a shared bus arrangement to reduce IO pin count.
> > > 2) Separate chip select lines
> > > 3) Shared I/O lines
> > > 4) This mode is targeted for increasing the flash memory and no performance
> > >    improvement when compared with single.

> > This is just a normal SPI controller from a SPI point of view.

> How can we really represent the stacked mode in current configuration?

In the same way as any other controller with two chip selects...  there
are quite a few other drivers that provide examples of this, you should
look for one that has hardware control similar to yours.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150715/3f47889c/attachment.sig>

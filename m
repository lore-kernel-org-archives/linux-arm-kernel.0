From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jul 2015 17:40:05 +0100
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
In-Reply-To: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <20150714164005.GE11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 06:14:53PM +0530, Ranjit Waghmode wrote:


> What is dual parallel mode?
> ---------------------------
> ZynqMP GQSPI controller supports Dual Parallel mode with following functionalities:
> 1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
> 2) Chip selects and clock are shared to both the flash devices
> 3) This mode is targeted for faster read/write speed and also doubles the size
> 4) Commands/data can be transmitted/received from both the devices(mirror),
>    or only upper or only lower flash memory devices.
> 5) Data arrangement:
>    With stripe enabled,
>    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
>    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.

For the SPI code this just seems like SPI with an 8 bit data width.

> What is stacked mode?
> ---------------------
> ZynqMP GQSPI controller supports stacked mode with following functionalities:
> 1) The Generic Quad-SPI controller also supports two SPI flash memories
>    in a shared bus arrangement to reduce IO pin count.
> 2) Separate chip select lines
> 3) Shared I/O lines
> 4) This mode is targeted for increasing the flash memory and no performance
>    improvement when compared with single.

This is just a normal SPI controller from a SPI point of view.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/6b2a0203/attachment.sig>

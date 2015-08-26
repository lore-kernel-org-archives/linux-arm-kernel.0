From: marex@denx.de (Marek Vasut)
Date: Wed, 26 Aug 2015 08:56:22 +0200
Subject: [LINUX RFC v2 0/4] spi: add dual parallel mode support in Zynq
 MPSoC GQSPI controller
In-Reply-To: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <201508260856.22258.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 26, 2015 at 08:26:03 AM, Ranjit Waghmode wrote:
> This series adds dual parallel mode support for Zynq Ultrascale+
> MPSoC GQSPI controller driver.
> 
> What is dual parallel mode?
> ---------------------------
> ZynqMP GQSPI controller supports Dual Parallel mode with following
> functionalities: 1) Supporting two SPI flash memories operating in
> parallel. 8 I/O lines. 2) Chip selects and clock are shared to both the
> flash devices
> 3) This mode is targeted for faster read/write speed and also doubles the
> size 4) Commands/data can be transmitted/received from both the
> devices(mirror), or only upper or only lower flash memory devices.
> 5) Data arrangement:
>    With stripe enabled,
>    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
>    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.

This might be a dumb question, but why don't you just treat this as an
SPI NOR flash with 8-bit bus ?

Best regards,
Marek Vasut

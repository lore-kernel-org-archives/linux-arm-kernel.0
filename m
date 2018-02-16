From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 16 Feb 2018 10:20:27 +0100
Subject: [PATCH] arm64: dts: rockchip: Fix RK3328 UART DMAs
In-Reply-To: <564d3e93476ae7480f927b1137ec4d0301938f16.1518702332.git.robin.murphy@arm.com>
References: <564d3e93476ae7480f927b1137ec4d0301938f16.1518702332.git.robin.murphy@arm.com>
Message-ID: <2444566.WmOARJqmXO@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 15. Februar 2018, 14:46:50 CET schrieb Robin Murphy:
> Using a serial console on RK3328 provokes an error from
> of_dma_request_slave_channel() since the UART nodes have a "dmas"
> property but are missing the mandatory "dma-names" to go with it.
> 
> Replace the bogus "#dma-cells" - these UARTs are DMA channel consumers,
> not providers - with the appropriate names instead. DMA still doesn't
> actually work, since the PL330 driver doesn't quite implement everything
> the 8250 driver demands, but at least it makes the DT correct.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

applied for 4.17

Thanks for the catch
Heiko

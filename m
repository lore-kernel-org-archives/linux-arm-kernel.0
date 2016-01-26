From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Jan 2016 12:27:50 -0700
Subject: [PATCH v2 2/2] ARM: tegra: Add high speed UARTs to Jetson TK1
 device tree
In-Reply-To: <1453827558-10954-3-git-send-email-ralf@ramses-pyramidenbau.de>
References: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
 <1453827558-10954-3-git-send-email-ralf@ramses-pyramidenbau.de>
Message-ID: <56A7C8B6.6090405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2016 09:59 AM, Ralf Ramsauer wrote:
> This patch enables the APB DMA high speed UARTs of the Jetson TK1. So
> far, they were only enabled in NVidia's official BSP.
>
> Those additional UARTs are exposed on the expansion connector J3A2:
>
>   UART1:
>    Pin 41: BR_UART1_TXD
>    Pin 44: BR_UART1_RXD
>
>   UART2:
>    Pin 65: UART2_RXD
>    Pin 68: UART2_TXD
>    Pin 71: UART2_CTS_L
>    Pin 74: UART2_RTS_L

The series,
Acked-by: Stephen Warren <swarren@nvidia.com>


As an aside, this is perfectly OK, but I wonder why you chose to use 
compatible=nvidia,tegra124-hsuart rather than 
compatible=nvidia,tegra124-uart. The -hsuart driver has had less testing 
upstream, whereas the regular -uart driver is heavily used for the main 
serial console. I assume you tested the new driver when enabling the 
ports:-)

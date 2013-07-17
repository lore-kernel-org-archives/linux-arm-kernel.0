From: b32955@freescale.com (Huang Shijie)
Date: Wed, 17 Jul 2013 15:30:12 +0800
Subject: [PATCH v4 0/6] serial: imx: add DMA support for imx6
In-Reply-To: <1373274862-2695-1-git-send-email-b32955@freescale.com>
References: <1373274862-2695-1-git-send-email-b32955@freescale.com>
Message-ID: <51E64804.4080902@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?08? 17:14, Huang Shijie ??:
> (1) This patch set adds the DMA support for the imx serial driver.
>     The uart with the dma support is usually used by the Bluetooth.
>
>     For the firmware's limit, i only enable the DMA for imx6 serials.
>     If we have proper firmware for imx53 (or other chips), we can also
>     enable the DMA for it.
>
> (2) We only enable the DMA support when the following are meet:
>
>     [1] The uart port supports the hardware flow control(CTS/RTS).
>       (Some uart port does not support the CTS/RTS.)
>
>     [2] The application enables the CTS/RTS.
>
>     [3] The Soc is imx6 serials.
>       For the sdma's firmware limit, we do not support the DMA except
>       the imx6 platform.
>
>     [4] The uart is not used as a console.
>
>
> (3) Tested this patch set by:
> 	connecting a imx6q-arm2 board(DTE) with a imx53 board(DCE).
>
> v3 --> v4:
> 	[0] add DTE pad for uart2
>
> v2 --> v3:
> 	[0] add a new patch to fix the RTS/CTS pad name issue.
> 	[1] rename the uart DTE pinctrl, remove the "dte" from the pinctrl.
> 	[2] add a similar UART DTE pinctrl for IMX6DL.
> 	[3] move the "fsl,imx6q-uart" to the first of the compatible table.
>
> v1 --> v2:
> 	[0] use the "fsl,imx6q-uart" as the new compatible value.
> 	[1] move dma_is_inited to imx_uart_dma_init();
> 	    move dma_is_enabled to imx_enable_dma();
> 	[2] move imx_disable_dma() to the front place of the imx_shutdown(),
> 	    just before calls the imx_uart_dma_exit().
> 	[3] misc    
> 	
>
> Huang Shijie (6):
>   serial: imx: distinguish the imx6q uart from the others
>   serial: imx: add DMA support for imx6q 
Hi Greg:
Could you merge the two patches as above?


thanks
Huang Shijie

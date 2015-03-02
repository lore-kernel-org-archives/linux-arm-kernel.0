From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 20:28:01 +0100
Subject: [PATCH] dma: xilinx-dma: move header file to common location
In-Reply-To: <4c3e2425e14646cb86c20d6aebdcfe22@BY2FFO11FD004.protection.gbl>
References: <4c3e2425e14646cb86c20d6aebdcfe22@BY2FFO11FD004.protection.gbl>
Message-ID: <2793259.VbbYy9Imif@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 23:24:24 Kedareswara rao Appana wrote:
> This patch moves the xilinx_dma.h header file
> to the include/linux/dma.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>

Please move this header file to drivers/dma/xilinx/ directly to
make it inaccessible by other driver. No driver should pass extra
data structures to a dmaengine driver.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Feb 2013 15:23:25 +0000
Subject: [PATCH V2 4/4] DMA: PL330: Modify pl330 filter based on new
 generic dma dt bindings.
In-Reply-To: <1359723116-18173-5-git-send-email-padma.v@samsung.com>
References: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
 <1359723116-18173-5-git-send-email-padma.v@samsung.com>
Message-ID: <201302011523.25771.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013, Padmavathi Venna wrote:
> This patch modify the filter function to filter the required channel
> based on new filter params.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

The result of this looks good, but I fear that changing the filter function
like this wil break all drivers that currently use the plat-samsung/dma-ops.c
code. For migration purposes, I think the best way is to change
samsung_dmadev_request() to match the new filter_param format.

After that is done, you can migrate all the drivers using samsung_dma_get_ops
over to the new dma_request_slave_channel interface without breaking
anything when only part of the series is applied.

	Arnd

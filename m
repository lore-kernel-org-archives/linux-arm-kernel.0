From: andi@etezian.org (andi at etezian.org)
Date: Wed, 18 Apr 2018 03:27:16 +0900
Subject: [PATCH v2 8/8] spi: spi-s3c64xx: Allow higher transfer lengths in
 polling IO mode
In-Reply-To: <20180417142954.5507-8-s.nawrocki@samsung.com>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143100epcas2p228d05e4de4ce06621635a523241d9824@epcas2p2.samsung.com>
 <20180417142954.5507-8-s.nawrocki@samsung.com>
Message-ID: <0401102d3363dae0cf2a19c3546428f2@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 17.04.2018 23:29, Sylwester Nawrocki wrote:
> Some variants of the SPI controller have no DMA support, in such case
> SPI transfers longer than the FIFO length are not currently properly
> handled by the driver. Fix it by doing multiple transfers in the
> s3c64xx_spi_transfer_one() function if the SPI transfer length exceeds
> the FIFO size.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

thank you! it looks good.

Unfortunately I don't have right now the device with me
to test it, in any case you can add

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi

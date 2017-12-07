From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Dec 2017 17:36:27 +0100
Subject: [PATCH] spi: sun6i: disable/unprepare clocks on remove
In-Reply-To: <20171207140453.55krsazvnfqr7ooe@agrajag.zerfleddert.de>
References: <20171207140453.55krsazvnfqr7ooe@agrajag.zerfleddert.de>
Message-ID: <20171207163627.i4nrojgveczjfeox@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 03:04:53PM +0100, Tobias Jordan wrote:
> sun6i_spi_probe() uses sun6i_spi_runtime_resume() to prepare/enable
> clocks, so sun6i_spi_remove() should use sun6i_spi_runtime_suspend() to
> disable/unprepare them if we're not suspended.
> Replacing pm_runtime_disable() by pm_runtime_force_suspend() will ensure
> that sun6i_spi_runtime_suspend() is called if needed.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Fixes: 3558fe900e8af spi: sunxi: Add Allwinner A31 SPI controller driver

This isn't the proper fixes format.

> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>

Once fixed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/1aaa8c26/attachment.sig>

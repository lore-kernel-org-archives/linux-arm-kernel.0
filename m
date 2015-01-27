From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 13:01:17 +0000
Subject: [PATCH 4/7] spi: spi-fsl-dspi: avoid preparing the clock two times
In-Reply-To: <1422356244-15629-5-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-5-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <20150127130117.GU21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 04:27:21PM +0530, Bhuvanchandra DV wrote:
> regmap_read/regmap_write will expect the peripheral clock
> to be enabled before accessing the registers of the peripheral.
> Since the peripheral clock is enabled separatly, avoid redundant clock
> prepare (with devm_regmap_init_mmio_clk) and use devm_regmap_init_mmio instead.

What's the advantage of this?  The clock API is refcounted so there
should be no issue with this and it seems like it's opening us up to
bugs if there's a path where we interact with the registers without
enabling the clocks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/ea749d88/attachment.sig>

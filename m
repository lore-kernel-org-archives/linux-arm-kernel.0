From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:03:42 +0000
Subject: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
In-Reply-To: <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <20150128190342.GE21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 04:33:28PM +0530, Bhuvanchandra DV wrote:

> TCFQ is interrupt of Transfer Complete Flag in DSPI module.
> EOQ is interrupt of End of Queue Flag in DSPI module.
> For adopting of different platform, either of them is a way of DSPI
> transfer data. This patch add TCF support for DSPI module  in other platform.

I can't really understand what the purpose of this is, sorry.  What are
these modes and why would one choose one over the other?  Your changelog
suggests this is being done per board which implies that it's tuning for
performance but that's usually something that should be done in device
drivers, not the device tree - perhaps the tuning will change over time
as the driver is optimized or perhaps it varies depending on the
transfer.

The code mentions a DMA option as well, generally where it's available
DMA is something that's chosen at runtime based on the length of the
transfer.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/cca55770/attachment.sig>

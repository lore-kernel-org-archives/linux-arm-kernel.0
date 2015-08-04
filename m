From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Aug 2015 18:19:31 +0100
Subject: [PATCH] spi: spi-sun4i, spi-sun6i: Fix bit rate calculation
In-Reply-To: <op.x2pmc5kiltbbtz@localhost>
References: <op.x2pmc5kiltbbtz@localhost>
Message-ID: <20150804171931.GZ20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 02, 2015 at 12:06:31AM +0200, Hermann Kraus wrote:

> +	u32 speed_hz = tfr->speed_hz ? : spi->max_speed_hz;

You don't need to do this anyway since the framework will always ensure
that speed_hz is set so you can just use it unconditionally but in
general please don't use the ternery operator unless it's adding
something, it's not a legibility triumph.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/c2012e8d/attachment.sig>

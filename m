From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:45:04 -0700
Subject: [PATCH 3/9] spi: sunxi: check that transfer speed is non-zero
In-Reply-To: <3688fab67e7cdc7bcbff73dfd6b0fcdcc4e79eb6.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
 <3688fab67e7cdc7bcbff73dfd6b0fcdcc4e79eb6.1440080122.git.hramrach@gmail.com>
Message-ID: <20150820184504.GP12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:19:46PM -0000, Michal Suchanek wrote:
> When the maximum transfer speed is not set for a SPI slave the value
> remains 0 and the code in sunxi SPI divides by it. Use an arbitrary
> speed instead in that case.

You should always be using the transfer speed that is defined per
transfer, the core will ensure that this is always set.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/db73391e/attachment.sig>

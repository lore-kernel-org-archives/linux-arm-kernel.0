From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 16:48:36 +0200
Subject: [PATCH 3/9] spi: sunxi: check that transfer speed is non-zero
In-Reply-To: <3688fab67e7cdc7bcbff73dfd6b0fcdcc4e79eb6.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
 <3688fab67e7cdc7bcbff73dfd6b0fcdcc4e79eb6.1440080122.git.hramrach@gmail.com>
Message-ID: <20150820144836.GV30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:19:46PM -0000, Michal Suchanek wrote:
> When the maximum transfer speed is not set for a SPI slave the value
> remains 0 and the code in sunxi SPI divides by it. Use an arbitrary
> speed instead in that case.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

spi->max_speed_hz is set using the spi-max-frequency property, and
spi->will error out if that property isn't set. What am I missing?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/45a045ea/attachment-0001.sig>

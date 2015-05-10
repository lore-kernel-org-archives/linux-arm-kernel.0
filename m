From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 May 2015 10:24:33 +0200
Subject: [PATCH] ARM: sunxi: dt: Split the SPI pinctrl groups
In-Reply-To: <1430639236-10785-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1430639236-10785-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150510082433.GB11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 03, 2015 at 09:47:16AM +0200, Maxime Ripard wrote:
> The pinctrl groups for SPI until now were also adding the chip selects in
> the SPI pinctrl group.
> 
> This was causing a few issues, since a board was forced to use a random
> number of chipselects, even though it might use one of these chip selects
> for another pin.
> 
> The number of chipselects defined was also not the same from one group to
> another because of different needs at the time these groups have been
> introduced, resulting in no clear view from the board DTS on what exactly
> is being muxed, which even might change in the future.
> 
> Solve this by creating different pinctrl groups for the chipselects and the
> standard SPI pins (CLK, MOSI and MISO) so that we fix both issues.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150510/67ae2005/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Jul 2016 10:18:30 +0200
Subject: [PATCH 2/4] mmc: sunxi: Make sample clocks optional
In-Reply-To: <1468665964-27142-3-git-send-email-hdegoede@redhat.com>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
 <1468665964-27142-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20160725081830.GF7419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jul 16, 2016 at 12:46:02PM +0200, Hans de Goede wrote:
> It turns out that sun4i (A10) and sun5i (A13 & co) do not have sample
> clocks, so make them optional.
> 
> Since these do not have sample clocks, they cannot (reliably) do
> DDR rates, so only set MMC_CAP_1_8V_DDR when we do have sample clks.
> 
> Note this patch only changes the devm_clk_get error checking and sets
> the clocks to NULL if they don't exists. All the clk_foo calls accept
> a NULL clk and will return success when called with a NULL clk, so this
> is all that is necessary.

The clocks aren't really optional. They're not needed for the A10 /
A13, and mandatory for the A20 and later.

Having a new compatible for the A20 that would require that clock and
not require it for the A10/A13 anymore seems more appropriate.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/dfdb0ee7/attachment-0001.sig>

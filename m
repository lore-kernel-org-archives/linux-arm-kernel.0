From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Nov 2016 09:44:58 +0100
Subject: [PATCH] ASoC: sun4i-codec: Enable bus clock after getting GPIO
In-Reply-To: <20161101063155.15826-1-wens@csie.org>
References: <20161101063155.15826-1-wens@csie.org>
Message-ID: <20161102084458.xhuwy5bsmacgs2wm@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 02:31:55PM +0800, Chen-Yu Tsai wrote:
> In the current probe function the GPIO is acquired after the codec's
> bus clock is enabled. However if it fails to acquire the GPIO due to
> a deferred probe, it does not disable the bus clock before bailing out.
> This would result in the clock being enabled multiple times.
> 
> Move the code that enables the bus clock after the part that gets the
> GPIO, maintaining a separation between resource acquisition and device
> enablement in the probe function.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/24a18996/attachment.sig>

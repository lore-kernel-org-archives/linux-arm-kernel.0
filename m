From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Jul 2017 09:32:29 +0200
Subject: [PATCH v3 01/10] clk: sunxi-ng: Add interface to query or
 configure MMC timing modes.
In-Reply-To: <20170724135905.28855-2-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
 <20170724135905.28855-2-wens@csie.org>
Message-ID: <20170725073229.fbm7ead455oudftc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 09:58:56PM +0800, Chen-Yu Tsai wrote:
> Starting with the A83T SoC, Allwinner introduced a new timing mode for
> its MMC clocks. The new mode changes how the MMC controller sample and
> output clocks are delayed to match chip and board specifics. There are
> two controls for this, one on the CCU side controlling how the clocks
> behave, and one in the MMC controller controlling what inputs to take
> and how to route them.
> 
> In the old mode, the MMC clock had 2 child clocks providing the output
> and sample clocks, which could be delayed by a number of clock cycles
> measured from the MMC clock's parent.
> 
> With the new mode, the 2 delay clocks are no longer active. Instead,
> the delays and associated controls are moved into the MMC controller.
> The output of the MMC clock is also halved.
> 
> The difference in how things are wired between the modes means that the
> clock controls and the MMC controls must match. To achieve this in a
> clear, explicit way, we introduce two functions for the MMC driver to
> use: one queries the hardware for the current mode set, and the other
> allows the MMC driver to request a mode.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/b8c97bef/attachment.sig>

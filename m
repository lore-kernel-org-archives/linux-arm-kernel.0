From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:25:50 +0100
Subject: [PATCH 09/15] clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
 output
In-Reply-To: <20181128093013.24442-11-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-11-wens@csie.org>
Message-ID: <20181128102550.qsipssx67y3uexsr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:07PM +0800, Chen-Yu Tsai wrote:
> On the R40, in addition to a mux between the RTC's own RC oscillator and
> an external 32768 Hz crystal, which are muxed inside the RTC module, the
> CCU also has its own RC oscillator, which runs at around 2 MHz, and can
> be muxed with the LOSC output from the RTC. This muxed output is called
> "SYS 32K" in the module clock diagram, but otherwise referred to as the
> LOSC throughout the CCU documentation.
> 
> The RC oscillator is not very accurate, even though it has an undocumented
> calibration function. We really want a precise clock at 32768 Hz,
> instead of something at around 32 KHz. This patch forces the SYS 32K
> clock to use the RTC output as its parent, and doesn't bother
> registering the internal oscillator nor a clock mux.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/931ba379/attachment.sig>

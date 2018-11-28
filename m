From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:22:12 +0100
Subject: [PATCH 06/15] rtc: sun6i: Add support for different variants
In-Reply-To: <20181128093013.24442-7-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-7-wens@csie.org>
Message-ID: <20181128102212.4sodbbk6uu52nug3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:03PM +0800, Chen-Yu Tsai wrote:
> Amongst the Allwinner SoCs that have seen some kind of coverage by the
> linux-sunxi community, whether it be mainline Linux or U-boot support,
> or just available datasheets, most newer chips use the RTC design first
> seen in the A31 (sun6i).
> 
> Overall there have been some minor differences. This patch covers the
> following:
> 
>   - average clock rate of the internal RC oscillator
>     + presence of fixed and adjustable prescaler for this clock
>   - availability of an external (to the SoC) clock output
> 
> One major difference regarding the H6 is the 24 MHz crystal is now
> routed through the RTC, as a digitally compensated oscillator (DCXO).
> This is not covered in this patch and will be supported later.
> 
> Other differences are either unrelated to RTC or clock functionality,
> such as boot or crypto related registers, or the driver simply doesn't
> use the feature in question. One example of the latter is the
> calibration function for the RC oscillator. We consider this clock to
> be very bad and avoid using it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/5bec8e9b/attachment.sig>

From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:27:45 +0100
Subject: [PATCH 12/15] ARM: dts: sunxi: h3/h5: Fix up RTC device node and
 clock references
In-Reply-To: <20181128093013.24442-14-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-14-wens@csie.org>
Message-ID: <20181128102745.v2dvq24jjf4vxrbd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:30:10PM +0800, Chen-Yu Tsai wrote:
> The RTC module on the H3 was claimed to be the same as on the A31, when
> in fact it is not. The A31 does not have an RTC external clock output,
> and its internal RC oscillator's average clock rate is not in the same
> range. The H5's RTC has some extra crypto-related registers compared to
> the H3. Their exact functions are not clear. Also the RTC-VIO regulator
> has different settings.
> 
> This patch fixes the compatible string and clock properties to conform
> to the updated bindings. The device node for the internal oscillator is
> removed, as it is internalized into the RTC device. Clock references to
> the IOSC and LOSC are also fixed.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

> squash! ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references

But you might want to remove that :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/80d9b983/attachment.sig>

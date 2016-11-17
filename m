From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Nov 2016 21:40:43 +0100
Subject: [PATCH] ARM: dts: sunxi: Explicitly enable pull-ups for MMC pins
In-Reply-To: <20161117093438.17988-1-wens@csie.org>
References: <20161117093438.17988-1-wens@csie.org>
Message-ID: <20161117204043.wz66gpsb4y2pt7yu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 05:34:38PM +0800, Chen-Yu Tsai wrote:
> In the past, all the MMC pins had
> 
> 	allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> 
> which was actually a no-op. We were relying on U-boot to set the bias
> pull up for us. These properties were removed as part of the fix up to
> actually support no bias on the pins. During the transition some boards
> experienced regular MMC time-outs during normal operation, while others
> completely failed to initialize the SD card.
> 
> Given that MMC starts in open-drain mode and the pull-ups are required,
> it's best to enable it for all the pin settings.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161117/a5739611/attachment.sig>

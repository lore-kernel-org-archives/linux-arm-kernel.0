From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 10:14:49 +0200
Subject: [PATCH] mmc: sunxi: Clarify new timing mode usage and
 implementation
In-Reply-To: <20180906153107.20225-1-wens@csie.org>
References: <20180906153107.20225-1-wens@csie.org>
Message-ID: <20180907081449.roowspmgmtd5zcs6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 11:31:07PM +0800, Chen-Yu Tsai wrote:
> Newer sunxi mmc controller variants support what they call the "new
> timing mode". Support for this was implemented in two ways, according
> to the hardware that was seen at the time.
> 
> The first type retained the old timing mode, and both the clock and mmc
> controllers had switches to select which mode was used. Both switches
> had to be set to the same setting. This variant was denoted with the
> .has_timings_switch field in the sunxi_mmc_cfg structure. This hardware
> is only seen on the A83T.
> 
> The second type did away with the old timing mode. The clock controller
> no longer had the mode selection or clock delay setting bits. In some
> cases the mmc controller retained its mode selection bit, but this
> always needed to be set to the new mode, or instabilities would occur.
> In a few cases, such as the A64 and H6 eMMC controller, the mode
> selection bit is gone, but the controller still behaves like the new
> timing mode, requiring the module clock to be double the card clock
> in DDR transfer modes. This variant is denoted with the
> .needs_new_timings field.
> 
> This patch adds more comments explaining the two fields, as well as
> the possibly nonexistent mode switch in the mmc controller.
> 
> The .has_timings_switch is renamed to .ccu_has_timings_switch to clarify
> its meaning.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/24241561/attachment.sig>

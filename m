From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Jul 2017 09:32:50 +0200
Subject: [PATCH v3 02/10] clk: sunxi-ng: Add MP_MMC clocks that support
 MMC timing modes switching
In-Reply-To: <20170724135905.28855-3-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
 <20170724135905.28855-3-wens@csie.org>
Message-ID: <20170725073250.vpxugsrlxzhsn2tb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 09:58:57PM +0800, Chen-Yu Tsai wrote:
> All of our MMC clocks are of the MP clock type. A few MMC clocks on some
> SoCs, such as MMC2 on the A83T, support new/old timing mode switching.
> 
> From a clock rate point of view, when the new timing mode is active. the
> output clock rate is halved.
> 
> This patch adds a special wrapper class of clocks, MP_MMC, around the
> generic MP type clocks. The rate related callbacks in ccu_mp_mmc_ops
> for this class look at the timing mode bit and apply the /2 post-divider
> when needed, before passing it through to the generic class ops,
> ccu_mp_ops.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/55ee6361/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 09:20:39 +0200
Subject: [PATCH v2 04/10] mmc: sunxi: Support controllers that can use
 both old and new timings
In-Reply-To: <20170720034452.15920-5-wens@csie.org>
References: <20170720034452.15920-1-wens@csie.org>
 <20170720034452.15920-5-wens@csie.org>
Message-ID: <20170721072039.qsko2vtradiosdqk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 11:44:46AM +0800, Chen-Yu Tsai wrote:
> On the SoCs that introduced the new timing mode for MMC controllers,
> both the old (where the clock delays are set in the CCU) and new
> (where the clock delays are set in the MMC controller) timing modes
> are available, and we have to support them both. However there are
> two bits that control which mode is active. One is in the CCU, the
> other is in the MMC controller. The settings on both sides must be
> the same, or nothing will work.
> 
> The sunxi-ng clock driver provides an API to query and set the
> active timing mode. At probe time, we try to set the active mode
> to the "new timing mode". If it succeeds, we can then use the MMC
> controller in the new mode. If not, we fall back to the old mode.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170721/6674acc1/attachment.sig>

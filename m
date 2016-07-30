From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Jul 2016 17:15:20 +0200
Subject: [PATCH v2 4/5] mmc: sunxi: sun4i / sun5i do not have sample clocks
In-Reply-To: <1469888748-26085-5-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-5-git-send-email-hdegoede@redhat.com>
Message-ID: <20160730151520.GQ6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 04:25:47PM +0200, Hans de Goede wrote:
> It turns out that sun4i (A10) and sun5i (A13 & co) do not have sample
> clocks, so add a new sun7i-a20-mmc compatible and do not try to use
> sample clocks on sun4i / sun5i.
> 
> Since sun4i / sun5i do not have sample clocks, they cannot (reliably) do
> DDR rates, so only set MMC_CAP_1_8V_DDR when we do have sample clks.
> 
> Note this patch leaves the clk_prepare_enable() / clk_disable_unprepare()
> calls to the sample clks as-is, without adding checks for them being
> NULL. All the clk_foo calls accept a NULL clk and will return success when
> called with a NULL clk.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/1770f321/attachment.sig>

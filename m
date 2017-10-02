From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Oct 2017 22:02:38 +0200
Subject: [PATCH v3 05/14] drm/sun4i: hdmi: Disable clks in bind function
 error path and unbind function
In-Reply-To: <20170929082306.16193-6-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-6-wens@csie.org>
Message-ID: <20171002200238.zdn3frmdi4b2hh2e@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 08:22:57AM +0000, Chen-Yu Tsai wrote:
> The HDMI driver enables the bus and mod clocks in the bind function, but
> does not disable them if it then bails our due to any errors. Neither
> does it disable the clocks in the unbind function.
> 
> Fix this by adding a proper error path to the bind function, and
> clk_disable_unprepare calls to the unbind function.
> 
> Also rename the err_cleanup_connector label to err_cleanup_encoder,
> since it is the encoder that gets cleaned up.
> 
> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171002/256b9df1/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 11:56:29 +0200
Subject: [PATCH v2 04/13] drm/sun4i: hdmi: Disable clks in bind function
 error path and unbind function
In-Reply-To: <20170926065919.24446-5-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
 <20170926065919.24446-5-wens@csie.org>
Message-ID: <20170926095629.hp3igc4zx7u6yn55@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 06:59:10AM +0000, Chen-Yu Tsai wrote:
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

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/4446e5a2/attachment.sig>

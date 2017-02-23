From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Feb 2017 10:26:18 -0800
Subject: [PATCH 06/11] drm/sun4i: Drop primary layer pointer from sun4i_drv
In-Reply-To: <20170223080543.6659-7-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
 <20170223080543.6659-7-wens@csie.org>
Message-ID: <20170223182618.tyxeu7p4x7ytsttk@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 04:05:38PM +0800, Chen-Yu Tsai wrote:
> The current layer init code keeps a pointer to the primary plane layer
> in sun4i_drv. When we eventually support multiple display pipelines,
> this would force us to keep track of primary planes for all crtcs. And
> these pointers only get used at bind time.
> 
> Instead, have the crtc init code iterate through the returned layers
> to find the primary and cursor layers. And drop the pointer from the
> sun4i_drv structure.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170223/951e7d3c/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 May 2016 14:38:08 +0200
Subject: [PATCH 1/6] drm: sun4i: do cleanup if RGB output init fails
In-Reply-To: <1463500571-28970-2-git-send-email-wens@csie.org>
References: <1463500571-28970-1-git-send-email-wens@csie.org>
 <1463500571-28970-2-git-send-email-wens@csie.org>
Message-ID: <20160525123808.GE9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 11:56:06PM +0800, Chen-Yu Tsai wrote:
> sun4i_rgb_init() can fail, which results in TCON failing to bind.
> In this case we need to do cleanup, specificly unregistering the
> dotclock, which is regmap based, and the regmap is registered as
> part of the sun4i_tcon_bind().
> 
> Failing to do so results in a NULL pointer reference when the CCF
> tries to turn off unused clocks.
> 
> Fixes: 29e57fab97fc ("drm: sun4i: Add RGB output")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160525/fd557265/attachment.sig>

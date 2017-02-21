From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 12:20:18 -0800
Subject: [PATCH 2/7] drm/sun4i: Fix up error path cleanup for master bind
 function
In-Reply-To: <20170217031330.14087-3-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
 <20170217031330.14087-3-wens@csie.org>
Message-ID: <20170221202018.eu42zc35reanrgsp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:13:25AM +0800, Chen-Yu Tsai wrote:
> The master bind function calls numerous drm functions which initialize
> underlying structures. It also tries to bind the various components
> of the display pipeline, some of which may add additional drm objects.
> 
> This patch adds proper cleanup functions in the error path of the
> master bind function.
> 
> This requires the patch "drm/sun4i: Move drm_mode_config_cleanup call
> to main driver", which splits out drm_mode_config_cleanup from
> sun4i_framebuffer_free so we can call it separately.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/9445a1c8/attachment.sig>

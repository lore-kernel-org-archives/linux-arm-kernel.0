From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Mar 2017 11:29:58 +0100
Subject: [PATCH 00/11] drm/sun4i: Support two display pipelines
In-Reply-To: <20170309100534.14023-1-wens@csie.org>
References: <20170309100534.14023-1-wens@csie.org>
Message-ID: <20170309102958.mlbpoklamob4ptfq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 06:05:23PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This is part 3 of my sun4i drm clean up series. In this part support
> for 2 display pipelines is added, after some more code cleanups and
> restructuring.
> 
> While this series enables the second display pipeline, there's no
> usable output at the moment. For the A31, the second TCON's panel
> interface uses the same pins as the Ethernet controller. However
> Ethernet is used on most boards. We will have to wait for HDMI
> support to actually use it.
> 
> Patch 1 fixes the TCON's clock and regmap initialization sequence,
> splitting out the dot clock init part till after the regmap.
> 
> Patch 2 fixes a comment spotted while reviewing Maxime's HDMI patches.
> 
> Patch 3 makes the crtc init code use the tcon pointer embedded in the
> crtc structure, instead of the sun4i_drv structure, to get the tcon's
> output port node. This should have been a part of the last batch of
> patches.
> 
> Patch 4 makes the tv encoder code get the tcon and backend pointers
> from its attached crtc.
> 
> Patch 5 makes the crtc init function take tcon and backend pointers.
> 
> Patch 6 makes the layer init functions take a backend pointer.

Applied the patches up to this one, see my comments for the rest of
the patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170309/fb8651f7/attachment.sig>

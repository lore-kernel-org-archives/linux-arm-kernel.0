From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Dec 2017 13:48:44 +0100
Subject: [PATCH] drm/sun4i: hdmi: Fix sun4i_tmds_determine_rate
In-Reply-To: <20171221112411.21550-1-net147@gmail.com>
References: <20171221112411.21550-1-net147@gmail.com>
Message-ID: <20171221124844.2ur26ijap3rtv2o7@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 21, 2017 at 10:24:11PM +1100, Jonathan Liu wrote:
> There are several issues in sun4i_tmds_determine_rate:
> - doesn't check if the best match was already set before comparing it
>   with the enumerated parameters which could result in integer divide
>   by zero
> - doesn't consider rate halving when determining closest match if it
>   can't match the requested rate exactly
> - sets best_div to i which corresponds to rate halving when it should be
>   set to j which corresponds to the divider
> 
> Fix these issues.
> 
> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> Signed-off-by: Jonathan Liu <net147@gmail.com>

Please make separate patches for each of these issues, if possible
detailing how do you reproduce them.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171221/555a6fd4/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 14:12:01 -0800
Subject: [PATCH 4/7] drm/sun4i: Fix kcalloc element size in
 sun4i_layers_init
In-Reply-To: <20170217031330.14087-5-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
 <20170217031330.14087-5-wens@csie.org>
Message-ID: <20170221221201.53pjfhvetaw32c7h@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:13:27AM +0800, Chen-Yu Tsai wrote:
> In sun4i_layers_init we are allocating an array of pointers to struct
> sun4i_layer:
> 
> 	layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes),
> 	                      sizeof(**layers), GFP_KERNEL);
> 
> The element size should be the size of an individual element of the
> array. Change it to sizeof(*layers) to avoid wasting a lot of memory.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/0bd4d4b1/attachment.sig>

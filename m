From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Nov 2016 09:23:14 +0100
Subject: [PATCH v2 01/14] ASoC: sun4i-codec: Move data structures to add
 create_card call to quirks
In-Reply-To: <20161103075556.29018-2-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-2-wens@csie.org>
Message-ID: <20161103082314.gtrb42pttayndnbc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:55:43PM +0800, Chen-Yu Tsai wrote:
> The audio codec on later Allwinner SoCs have a different layout and
> audio path compared to the A10/A20. However the PCM parts are still
> the same.
> 
> The different layout and audio paths mean we need a different
> create_card function for different families, so they can create
> DAPM endpoint widgets and routes.
> 
> This patch moves the regmap configs, quirks and of_device_id
> structures to just before the probe function, so we can, among other
> things, include a pointer for the create_card function. None of the
> lines of code were changed.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/80d51ad8/attachment.sig>

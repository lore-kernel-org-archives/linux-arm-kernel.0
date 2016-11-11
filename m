From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Nov 2016 09:29:14 +0100
Subject: [PATCH] pinctrl: sunxi: Free configs in pinctrl_map only if it
 is a config map
In-Reply-To: <20161111023510.14146-1-wens@csie.org>
References: <20161111023510.14146-1-wens@csie.org>
Message-ID: <20161111082914.yz52rlhevzvnoac3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 10:35:10AM +0800, Chen-Yu Tsai wrote:
> In the recently refactored sunxi pinctrl library, we are only allocating
> one set of pin configs for each pinmux setting node. When the pinctrl_map
> structure is freed, the pin configs should also be freed. However the
> code assumed the first map would contain the configs, which actually
> never happens, as the mux function map gets added first.
> 
> The proper way to do this is to look through all the maps and free the
> first one whose type is actually PIN_MAP_TYPE_CONFIGS_GROUP.
> 
> Also slightly expand the comment explaining this.
> 
> Fixes: f233dbca6227 ("pinctrl: sunxi: Rework the pin config building code")
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/e741e672/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Nov 2016 09:38:52 +0100
Subject: [PATCH v2 3/3] pinctrl: sunxi: Make sunxi_pconf_group_set use
 sunxi_pconf_reg helper
In-Reply-To: <20161111024455.16883-4-wens@csie.org>
References: <20161111024455.16883-1-wens@csie.org>
 <20161111024455.16883-4-wens@csie.org>
Message-ID: <20161111083852.yacy33g6pag6ucon@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 10:44:55AM +0800, Chen-Yu Tsai wrote:
> The sunxi_pconf_reg helper introduced in the last patch gives us the
> chance to rework sunxi_pconf_group_set to have it match the structure
> of sunxi_pconf_(group_)get and make it easier to understand.
> 
> For each config to set, it:
> 
>     1. checks if the parameter is supported.
>     2. checks if the argument is within limits.
>     3. converts argument to the register value.
>     4. writes to the register with spinlock held.
> 
> As a result the function now blocks unsupported config parameters,
> instead of silently ignoring them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

But I think the config variable removal should be part of patch 2, as
discussed there.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/67b851bb/attachment.sig>

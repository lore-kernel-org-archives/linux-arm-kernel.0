From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Nov 2016 08:56:03 +0100
Subject: [PATCH 2/2] clk: sunxi-ng: fix up PLL_CPUX adjusting for A23/A33
In-Reply-To: <20161106172932.39478-2-icenowy@aosc.xyz>
References: <20161106172932.39478-1-icenowy@aosc.xyz>
 <20161106172932.39478-2-icenowy@aosc.xyz>
Message-ID: <20161107075603.zad2kgzvh5lr7zeh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Same remark for the commit title.

On Mon, Nov 07, 2016 at 01:29:32AM +0800, Icenowy Zheng wrote:
> When adjusting PLL_CPUX on A23/A33, the PLL is driven too high, and the
> system stucks.
> 
> Add a notifier to avoid this situation.
> 
> The code is ported from ccu-sun6i-a31.c.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Patch 4.9-rc too.
>  drivers/clk/sunxi-ng/ccu-sun8i-a23.c | 10 ++++++++++

Have you checked that it was also needed on A23? Not all SoCs are in
this situation.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/c6eb2990/attachment.sig>

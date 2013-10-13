From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 13 Oct 2013 23:47:06 +0000 (UTC)
Subject: [PATCHv8 01/36] CLK: TI: Add DPLL clock support
In-Reply-To: <1381332668-962-2-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
 <1381332668-962-2-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310132345400.27397@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Tero Kristo wrote:

> The OMAP clock driver now supports DPLL clock type. This patch also
> adds support for DT DPLL nodes.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

By the way:

> +
> +	if (of_property_read_bool(node, "ti,low-power-stop"))
> +		dpll_mode |= 1 << DPLL_LOW_POWER_STOP;
> +
> +	if (of_property_read_bool(node, "ti,low-power-bypass"))
> +		dpll_mode |= 1 << DPLL_LOW_POWER_STOP;

This doesn't look right.  Could you please check it?


- Paul

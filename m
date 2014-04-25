From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 25 Apr 2014 16:18:49 +0200
Subject: [PATCH v2 03/18] usb: host: xhci-plat: Add support for the
 Armada 38x
In-Reply-To: <1398434836-18908-4-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140425161849.5616821e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 25 Apr 2014 16:07:01 +0200, Gregory CLEMENT wrote:

> +#define USB3_MAX_WINDOWS	4
> +#define USB3_WIN_CTRL(w)	(0x0 + ((w) * 8))
> +#define USB3_WIN_BASE(w)	(0x4 + ((w) * 8))
> +
> +static void __init mv_usb3_conf_mbus_windows(void __iomem *base,
> +			const struct mbus_dram_target_info *dram)

That's a nitpick, but the name of this function looks like it was
copy/pasted from the Marvell LSP, and isn't very consistent with the
other function name. What about:

	xhci_mvebu_mbus_config()

instead, or something like that?

> +int xhci_mvebu_mbus_init_quirk(struct platform_device *pdev)

I believe this should give you a warning about section mismatch: you
have a non-init function calling an __init function, no?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

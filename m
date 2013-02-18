From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 17 Feb 2013 17:23:34 -0800 (PST)
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: add SATA support
In-Reply-To: <201302170143.36052.sergei.shtylyov@cogentembedded.com>
References: <201302170143.36052.sergei.shtylyov@cogentembedded.com>
Message-ID: <874nhao1nx.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add SATA clock and platform device resources on r8a7779 SoC.
> Add entry to r8a7779_auxdata_lookup[], so that devm_clk_get() in the driver
> still works when we're using the device tree.
>  
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
(snip)

>  	/* MSTP32 clocks */
> +	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
>  	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
>  	CLKDEV_DEV_ID("ohci-platform.1", &mstp_clks[MSTP101]), /* USB OHCI port2 */
>  	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
(snip)
>  static const struct of_dev_auxdata r8a7779_auxdata_lookup[] __initconst = {
> +	OF_DEV_AUXDATA("renesas,rcar-sata", 0xfc600000, "sata_rcar", NULL),

??
Is this settings really required for DT ??

I guess you can remove it, and add

 +	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), // for platform
 +	CLKDEV_DEV_ID("fc600000.sata_rcar", &mstp_clks[MSTP115]), // for DT

And...

> [1/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
> [2/4] ARM: mach-shmobile: r8a7779: add SATA support
> [3/4] libata: add R-Car SATA driver
> [4/4] ARM: mach-shmobile: marzen: add SATA support

I believe [3/4] patch should be base patch ?

Best regards
---
Kuninori Morimoto

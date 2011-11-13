From: michael@walle.cc (Michael Walle)
Date: Sun, 13 Nov 2011 21:53:32 +0100
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers and
 into platform.
In-Reply-To: <1321128007-3520-4-git-send-email-andrew@lunn.ch>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
 <1321128007-3520-4-git-send-email-andrew@lunn.ch>
Message-ID: <201111132153.32503.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag 12 November 2011, 21:00:05 schrieb Andrew Lunn:
> --- a/arch/arm/plat-orion/include/plat/addr-map.h
> +++ b/arch/arm/plat-orion/include/plat/addr-map.h
> @@ -50,4 +50,12 @@ void __init orion_setup_cpu_win(const struct
> orion_addr_map_cfg *cfg,
> 
>  void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg
> *cfg, const u32 ddr_window_cpu_base);
> +
> +void mv_xor_conf_mbus_windows(void __iomem *base);
> +void ehci_orion_conf_mbus_windows(void __iomem *base);
> +void mv_sata_conf_mbus_windows(void __iomem *base);
> +u32 mv643xx_eth_conf_mbus_windows(void __iomem *base);
> +void mv_sd_conf_mbus_windows(void __iomem *base);
this should be mvsd_conf_mbus_windows.

> +void kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
> +				    unsigned long dma);
>  #endif

-- 
Michael

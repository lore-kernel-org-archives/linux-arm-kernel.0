From: davem@davemloft.net (David Miller)
Date: Wed, 08 Aug 2012 16:08:50 -0700 (PDT)
Subject: [PATCH 07/11] net/stmmac: mark probe function as __devinit
In-Reply-To: <1344437248-20560-8-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-8-git-send-email-arnd@arndb.de>
Message-ID: <20120808.160850.2106318395245281875.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  8 Aug 2012 16:47:24 +0200

> Driver probe functions are generally __devinit so they will be
> discarded after initialization for non-hotplug kernels.
> This was found by a new warning after patch 6a228452d "stmmac: Add
> device-tree support" adds a new __devinit function that is called
> from stmmac_pltfr_probe.
> 
> Without this patch, building socfpga_defconfig results in:
> 
> WARNING: drivers/net/ethernet/stmicro/stmmac/stmmac.o(.text+0x5d4c): Section mismatch in reference from the function stmmac_pltfr_probe() to the function .devinit.text:stmmac_probe_config_dt()
> The function stmmac_pltfr_probe() references
> the function __devinit stmmac_probe_config_dt().
> This is often because stmmac_pltfr_probe lacks a __devinit
> annotation or the annotation of stmmac_probe_config_dt is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: netdev at vger.kernel.org

Applied, thanks.

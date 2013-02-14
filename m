From: davem@davemloft.net (David Miller)
Date: Thu, 14 Feb 2013 17:52:59 -0500 (EST)
Subject: [PATCH 6/9] net: cwdavinci_cpdma: export symbols for cpsw
In-Reply-To: <1360882071-4072668-7-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-7-git-send-email-arnd@arndb.de>
Message-ID: <20130214.175259.958737100257982860.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Feb 2013 23:47:48 +0100

> With the support for ARM AM33xx in multiplatform kernels
> in 3.9, an older bug appears in ARM allmodconfig:
> When the cpsw driver is built as a module with cpdma
> support enabled, it uses symbols that the cpdma driver
> does not export.
> 
> Without this patch, building allmodconfig results in:
> 
> ERROR: "cpdma_ctlr_int_ctrl" [drivers/net/ethernet/ti/ti_cpsw.ko] undefined!
> ERROR: "cpdma_control_set" [drivers/net/ethernet/ti/ti_cpsw.ko] undefined!
> ERROR: "cpdma_ctlr_eoi" [drivers/net/ethernet/ti/ti_cpsw.ko] undefined!
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>

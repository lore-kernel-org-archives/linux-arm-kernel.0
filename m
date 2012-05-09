From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 9 May 2012 11:21:57 +0000
Subject: [PATCH 3/3] ARM: OMAP2+: Kconfig: convert SOC_OMAPAM33XX to
 SOC_AM33XX
In-Reply-To: <1336514576-4870-4-git-send-email-khilman@ti.com>
References: <1336514576-4870-1-git-send-email-khilman@ti.com>
 <1336514576-4870-4-git-send-email-khilman@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1C30C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 03:32:56, Hilman, Kevin wrote:
> No need to have an OMAP prefix on these SoCs that are in the family
> but arent' really called OMAP.
> 
> Simple rename: CONFIG_SOC_OMAPAM33XX --> CONFIG_SOC_AM33XX
> 
> No functional change.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig  |    2 +-
>  arch/arm/mach-omap2/common.h |    2 +-
>  arch/arm/mach-omap2/io.c     |    4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 

Missed one place to change, Can you merge the below diff?


diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index b42252c..1b173a6 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -51,7 +51,7 @@ config TI_DAVINCI_CPDMA

 config TI_CPSW
        tristate "TI CPSW Switch Support"
-       depends on ARM && (ARCH_DAVINCI || SOC_OMAPAM33XX)
+       depends on ARM && (ARCH_DAVINCI || SOC_AM33XX)
        select TI_DAVINCI_CPDMA
        select TI_DAVINCI_MDIO
        ---help---


Thanks,
Vaibhav

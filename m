From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 28 Jun 2012 09:32:03 +0000
Subject: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
In-Reply-To: <20120627145844.GL3483@atomide.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 27, 2012 at 20:28:45, Tony Lindgren wrote:

> The last patch in this series causes onenand not to show
> up on my n900. I believe the problem has been there earlier
> too, but I just did not notice it.

Sorry for the delayed response, could reach workplace a short
while ago only

Could the diff [1] be tried and check whether it resolves the issue,

Regards
Afzal

[1]
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index c8a9487..bbae674 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -364,6 +364,8 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
        struct gpmc_timings t;
        int ret;

+       omap2_onenand_set_async_mode(onenand_base);
+
        t = omap2_onenand_calc_async_timings();

        ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);

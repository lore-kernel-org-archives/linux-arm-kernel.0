From: pavel@denx.de (Pavel Machek)
Date: Wed, 20 Mar 2013 14:46:12 +0100
Subject: [PATCHv2 2/2] ARM: socfpga: Add clock entries into device tree
In-Reply-To: <1363707936-17769-2-git-send-email-dinguyen@altera.com>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
 <1363707936-17769-2-git-send-email-dinguyen@altera.com>
Message-ID: <20130320134612.GA27793@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Adds the main PLL clock groups for SOCFPGA into device tree file
> so that the clock framework to query the clock and clock rates
> appropriately.

Is there an easy way to test it?

I was keeping modified clk.c with hardcoded clock to have working
ethernet; I reverted that patch and applied 2/2, but now NFS root
refuses to mount (similar symptoms to missing clk.c modifications).

Also I need following patch to get it to compile:

commit f85232eec5330e64984facd300ef864c53a326f5
Author: Pavel Machek <pavel@pollux.denx.de>
Date:   Wed Mar 20 14:41:59 2013 +0100

    Patch needed to get clk.c to compile.
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index da6b461..3504dbf 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -49,6 +49,7 @@ struct socfpga_clk {
 	void __iomem *reg;
 	char *parent_name;
 	char *clk_name;
+	int fixed_div;
 };
 #define to_socfpga_clk(p) container_of(p, struct socfpga_clk, hw)
 

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

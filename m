From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 10:07:12 +0200
Subject: [PATCHv4 3/9] ARM: orion: pass the i2c registers definition through
 the platform data
In-Reply-To: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1371024438-16631-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the existing platform data users of the MV64XXX i2c driver to
pass the registers offset structure along with the platform data.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/plat-orion/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index c019b7a..c166fc9 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -509,6 +509,7 @@ void __init orion_ge00_switch_init(struct dsa_platform_data *d, int irq)
  ****************************************************************************/
 static struct mv64xxx_i2c_pdata orion_i2c_pdata = {
 	.freq_n		= 3,
+	.regs		= &mv64xxx_i2c_regs_mv64xxx,
 	.timeout	= 1000, /* Default timeout of 1 second */
 };
 
@@ -524,6 +525,7 @@ static struct platform_device orion_i2c = {
 
 static struct mv64xxx_i2c_pdata orion_i2c_1_pdata = {
 	.freq_n		= 3,
+	.regs		= &mv64xxx_i2c_regs_mv64xxx,
 	.timeout	= 1000, /* Default timeout of 1 second */
 };
 
-- 
1.8.3

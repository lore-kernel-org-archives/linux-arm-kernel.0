From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 16:14:47 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mailbox tree
Message-ID: <20130621161447.aa6c3eac42d9f1d26e39bc5f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/omap_hwmod_44xx_data.c between commit 4a1c0e83bb4e
("ARM: OMAP2+: mbox: remove dependencies with soc.h") from the mailbox
tree and commit 3b9b10151c68 ("ARM: OMAP4: hwmod data: Clean up the data
file") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4065962,d04b5e6..0000000
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@@ -1862,22 -1573,6 +1574,17 @@@ static struct omap_hwmod_class omap44xx
  };
  
  /* mailbox */
 +static struct omap_mbox_dev_info omap44xx_mailbox_info[] = {
 +	{ .name = "mbox-ipu", .tx_id = 0, .rx_id = 1 },
 +	{ .name = "mbox-dsp", .tx_id = 3, .rx_id = 2 },
 +};
 +
 +static struct omap_mbox_pdata omap44xx_mailbox_attrs = {
 +	.intr_type	= MBOX_INTR_CFG_TYPE2,
 +	.info_cnt	= ARRAY_SIZE(omap44xx_mailbox_info),
 +	.info		= omap44xx_mailbox_info,
 +};
 +
- static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
- 	{ .irq = 26 + OMAP44XX_IRQ_GIC_START },
- 	{ .irq = -1 }
- };
- 
  static struct omap_hwmod omap44xx_mailbox_hwmod = {
  	.name		= "mailbox",
  	.class		= &omap44xx_mailbox_hwmod_class,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/b4a13a3c/attachment.sig>

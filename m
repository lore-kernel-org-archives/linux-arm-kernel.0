From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 13 Sep 2012 16:41:20 +1000
Subject: linux-next: manual merge of the arm-soc tree with the i2c-embedded
 tree
Message-ID: <20120913164120.cde08ac1517e641386b147d8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/i2c/busses/i2c-omap.c between commit d9ebd04d3476 ("i2c: omap:
switch to devm_* API") from the i2c-embedded tree and commit 07baca6f8fc2
("i2c/i2c-omap: add a const qualifier") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/i2c/busses/i2c-omap.c
index c78431a,a0e49f6..0000000
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@@ -1051,11 -943,12 +1051,12 @@@ omap_i2c_probe(struct platform_device *
  {
  	struct omap_i2c_dev	*dev;
  	struct i2c_adapter	*adap;
 -	struct resource		*mem, *irq, *ioarea;
 +	struct resource		*mem;
- 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
+ 	const struct omap_i2c_bus_platform_data *pdata =
+ 		pdev->dev.platform_data;
  	struct device_node	*node = pdev->dev.of_node;
  	const struct of_device_id *match;
 -	irq_handler_t isr;
 +	int irq;
  	int r;
  
  	/* NOTE: driver uses the static register mapping */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120913/3d870509/attachment.sig>

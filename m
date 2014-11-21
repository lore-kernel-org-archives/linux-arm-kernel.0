From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Nov 2014 16:41:31 +1100
Subject: linux-next: manual merge of the driver-core tree with the arm-soc tree
Message-ID: <20141121164131.0190e0ab@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Today's linux-next merge of the driver-core tree got a conflict in
drivers/bus/omap_l3_noc.c between commit 61b43d4e919e ("bus:
omap_l3_noc: Add resume hook to restore context") from the arm-soc tree
and commit 571b8c6adb1b ("bus: drop owner assignment from
platform_drivers") from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/bus/omap_l3_noc.c
index 17d86595951c,1ff1863415c5..000000000000
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@@ -358,8 -300,6 +358,7 @@@ static struct platform_driver omap_l3_d
  	.probe		= omap_l3_probe,
  	.driver		= {
  		.name		= "omap_l3_noc",
- 		.owner		= THIS_MODULE,
 +		.pm		= L3_DEV_PM_OPS,
  		.of_match_table = of_match_ptr(l3_noc_match),
  	},
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/ed4a5a9c/attachment.sig>

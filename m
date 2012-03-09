From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 9 Mar 2012 18:17:55 +1100
Subject: linux-next: manual merge of the arm-soc tree with the regulator tree
Message-ID: <20120309181755.256b898808bd14726de0e977@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/regulator/Makefile between commit 8aa1ab9219e7 ("regulator: Sort
Kconfig and Makefile entries") from the regulator tree and commit
8a16a701ad78 ("regulator: Remove bq24022 regulator driver") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/regulator/Makefile
index 2b09c81,f53cf80..0000000
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@@ -10,17 -10,7 +10,16 @@@ obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER
  obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
  
  obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
 +obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
 +obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
 +obj-$(CONFIG_REGULATOR_AB3100) += ab3100.o
 +obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500.o
  obj-$(CONFIG_REGULATOR_AD5398) += ad5398.o
- obj-$(CONFIG_REGULATOR_BQ24022) += bq24022.o
 +obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 +obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
 +obj-$(CONFIG_REGULATOR_DBX500_PRCMU) += dbx500-prcmu.o
 +obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
 +obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
  obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
  obj-$(CONFIG_REGULATOR_LP3972) += lp3972.o
  obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/fa6284a1/attachment-0001.sig>

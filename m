From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 9 Mar 2012 18:15:17 +1100
Subject: linux-next: manual merge of the arm-soc tree with the regulator tree
Message-ID: <20120309181517.dce3405dc696afdf1a29be39@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/regulator/Kconfig between commit 8aa1ab9219e7 ("regulator: Sort
Kconfig and Makefile entries") from the regulator tree and commit
8a16a701ad78 ("regulator: Remove bq24022 regulator driver") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/regulator/Kconfig
index c733df5,740f468..0000000
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@@ -232,32 -233,6 +232,24 @@@ config REGULATOR_AB310
  	 AB3100 analog baseband dealing with power regulators
  	 for the system.
  
 +config REGULATOR_AB8500
 +	bool "ST-Ericsson AB8500 Power Regulators"
 +	depends on AB8500_CORE
 +	help
 +	  This driver supports the regulators found on the ST-Ericsson mixed
 +	  signal AB8500 PMIC
 +
 +config REGULATOR_DBX500_PRCMU
 +	bool
 +
 +config REGULATOR_DB8500_PRCMU
 +	bool "ST-Ericsson DB8500 Voltage Domain Regulators"
 +	depends on MFD_DB8500_PRCMU
 +	select REGULATOR_DBX500_PRCMU
 +	help
 +	  This driver supports the voltage domain regulators controlled by the
 +	  DB8500 PRCMU
 +
- config REGULATOR_BQ24022
- 	tristate "TI bq24022 Dual Input 1-Cell Li-Ion Charger IC"
- 	help
- 	  This driver controls a TI bq24022 Charger attached via
- 	  GPIOs. The provided current regulator can enable/disable
- 	  charging select between 100 mA and 500 mA charging current
- 	  limit.
- 
  config REGULATOR_TPS6105X
  	tristate "TI TPS6105X Power regulators"
  	depends on TPS6105X
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/30db3859/attachment-0001.sig>

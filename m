From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Mar 2017 16:07:42 +0100
Subject: next-20170330 build: 2 failures 8 warnings (next-20170330)
In-Reply-To: <E1ctZXC-0008DB-4g@optimist>
References: <E1ctZXC-0008DB-4g@optimist>
Message-ID: <20170330150742.wflswzqhg53mozx2@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 01:50:39PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/mtd/nand/atmel/nand-controller.c:2126:25: error: 'atmel_nc_id_table' undeclared here (not in a function)
> ../include/linux/module.h:212:27: error: '__mod_of__atmel_nc_id_table_device_table' aliased to undefined symbol 'atmel_nc_id_table'

caused by d09703f9459c94c78e029 (mtd: nand: Cleanup/rework the
atmel_nand driver), it tries to export atmel_nc_id_table as the DT ID
table but the variable is called atmel_nand_controller_of_ids. 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170330/3e30ecf8/attachment-0001.sig>

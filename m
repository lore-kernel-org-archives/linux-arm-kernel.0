From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Mar 2017 17:39:27 +0200
Subject: next-20170330 build: 2 failures 8 warnings (next-20170330)
In-Reply-To: <20170330150742.wflswzqhg53mozx2@sirena.org.uk>
References: <E1ctZXC-0008DB-4g@optimist>
 <20170330150742.wflswzqhg53mozx2@sirena.org.uk>
Message-ID: <20170330173927.5665a0da@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, 30 Mar 2017 16:07:42 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 30, 2017 at 01:50:39PM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an ARM allmodconfig due to:
> 
> > 	arm-allmodconfig
> > ../drivers/mtd/nand/atmel/nand-controller.c:2126:25: error: 'atmel_nc_id_table' undeclared here (not in a function)
> > ../include/linux/module.h:212:27: error: '__mod_of__atmel_nc_id_table_device_table' aliased to undefined symbol 'atmel_nc_id_table'  
> 
> caused by d09703f9459c94c78e029 (mtd: nand: Cleanup/rework the
> atmel_nand driver), it tries to export atmel_nc_id_table as the DT ID
> table but the variable is called atmel_nand_controller_of_ids. 

Pushed a fixed version to nand/next.

Thanks for the report.

Boris

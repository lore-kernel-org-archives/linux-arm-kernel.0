From: gerg@uclinux.org (Greg Ungerer)
Date: Tue, 05 Nov 2013 12:56:32 +1000
Subject: [PATCHv3] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <20131105012432.GA19770@S2101-09.ap.freescale.net>
References: <1383524020-1518-1-git-send-email-gerg@uclinux.org>
 <20131105012432.GA19770@S2101-09.ap.freescale.net>
Message-ID: <52785E60.6000709@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/13 11:24, Shawn Guo wrote:
> On Mon, Nov 04, 2013 at 10:13:40AM +1000, gerg at uclinux.org wrote:
>> @@ -0,0 +1,36 @@
>> +/*
>> + * Copyright 2013 Greg Ungerer <gerg@uclinux.org>
>> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + * Copyright 2011 Linaro Ltd.
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#include <linux/of_platform.h>
>> +#include <asm/mach/arch.h>
>> +
>> +#include "common.h"
>> +
>> +static void __init imx50_dt_init(void)
>> +{
> 
> We need to call mxc_arch_reset_init_dt() here to get mxc_restart() work.
> I just fixed it up and applied the patch.

Great, thanks Shawn.

Regards
Greg



>> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> +}
>> +
>> +static const char *imx50_dt_board_compat[] __initdata = {
>> +	"fsl,imx50",
>> +	NULL
>> +};
>> +
>> +DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
>> +	.map_io		= mx53_map_io,
>> +	.init_irq	= mx53_init_irq,
>> +	.handle_irq	= imx50_handle_irq,
>> +	.init_machine	= imx50_dt_init,
>> +	.dt_compat	= imx50_dt_board_compat,
>> +	.restart	= mxc_restart,
>> +MACHINE_END
>> -- 
>> 1.8.1.4
>>
> 
> 

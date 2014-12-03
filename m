From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Wed, 3 Dec 2014 17:17:13 +0800
Subject: [PATCH v3 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <54761BFC.4020705@ti.com>
References: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-6-git-send-email-chunyan.zhang@spreadtrum.com>
 <54761BFC.4020705@ti.com>
Message-ID: <CAAfSe-u+g0mYGi9Adrd+YwwZ=q0-s79yCg_paB1UAVqFoufXEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-27 2:29 GMT+08:00 Murali Karicheri <m-karicheri2@ti.com>:
>
> On 11/25/2014 07:16 AM, Chunyan Zhang wrote:
>>
>> Add a full sc9836-uart driver for SC9836 SoC which is based on the
>> spreadtrum sharkl64 platform.
>> This driver also support earlycon.
>>
>> [...]


>>
>> +++ b/drivers/tty/serial/sprd_serial.c
>> @@ -0,0 +1,752 @@
>> +/*
>> + * Copyright (C) 2012 Spreadtrum Communications Inc.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include<linux/module.h>
>> +#include<linux/tty.h>
>> +#include<linux/ioport.h>
>> +#include<linux/console.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/tty_flip.h>
>> +#include<linux/serial_core.h>
>> +#include<linux/serial.h>
>> +#include<linux/delay.h>
>> +#include<linux/io.h>
>> +#include<asm/irq.h>
>> +#include<linux/slab.h>
>> +#include<linux/of.h>
>> +#include<linux/kernel.h>
>> +#include<linux/slab.h>
>> +#include<linux/clk.h>
>
> How about sorting this includes? asm/irq.h go first followed linux/ in alphabatical order?


There are a few compile warnings if I moved asm/irq.h to the top of
all included files.
Warning details are below:

In file included from drivers/tty/serial/sprd_serial.c:14:0:
./arch/arm64/include/asm/irq.h:6:39: warning: ?struct pt_regs?
declared inside parameter list [enabled by default]
 extern void (*handle_arch_irq)(struct pt_regs *);
                                       ^
./arch/arm64/include/asm/irq.h:6:39: warning: its scope is only this
definition or declaration, which is probably not what you want
[enabled by default]
./arch/arm64/include/asm/irq.h:8:54: warning: ?struct pt_regs?
declared inside parameter list [enabled by default]
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));

Thanks,
Chunyan

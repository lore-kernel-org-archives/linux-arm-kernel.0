From: srplsnh@gmail.com (Surinder P Singh)
Date: Thu, 24 Sep 2009 20:26:56 +0530
Subject: [PATCH 1/3] [ARM]: U8500 core machine support
In-Reply-To: <f2235a630909240743t1fddabbct7c8ea0c4f77dbf73@mail.gmail.com>
References: <1253572622.21542.45.camel@vinay-desktop>
	<f2235a630909240743t1fddabbct7c8ea0c4f77dbf73@mail.gmail.com>
Message-ID: <f2235a630909240756w658f84fai668b6d4d9fe3edb6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 8:13 PM, Surinder P Singh <srplsnh@gmail.com> wrote:
> Some review comments:
>
>> diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
>> +
>> +#include <linux/amba/serial.h>
>> + ? ? ? ? ? ? ? .macro ?addruart,rx
>> + ? ? ? ? ? ? ? mrc ? ? p15, 0, \rx, c1, c0
>> + ? ? ? ? ? ? ? tst ? ? \rx, #1 ? ? ? ? ? ? ? ? @MMU enabled?
>> + ? ? ? ? ? ? ? moveq ? \rx, #0x80007000 ? ? ? ?@MMU off, Physical address
>> + ? ? ? ? ? ? ? movne ? \rx, #0xF0007000 ? ? ? ?@MMU on, Virtual address
>> + ? ? ? ? ? ? ? .endm
>> +
>
> It looks like the constants used here will break compilation. You
> could instead use 0x80000000 and 0xf0000000 and add an 'orr \rx, \rx,
> #0x7000' after the 'movne' to fix this.
>

You can also remove serial.h from here since this is now included in
debug-pl01x.S

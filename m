From: niej0001@gmail.com (Jun Nie)
Date: Mon, 23 Nov 2009 13:55:22 +0800
Subject: [PATCH 8/8] pxa: add frame buffer on pxa910 ttc_dkb platform
In-Reply-To: <20091119091323.GD13376@n2100.arm.linux.org.uk>
References: <7c34ac520911160135x2133c734ub15db7abc64b22a3@mail.gmail.com>
	<7c34ac520911190104n664ae2a2u31a4fdb63385da7c@mail.gmail.com>
	<20091119091323.GD13376@n2100.arm.linux.org.uk>
Message-ID: <7c34ac520911222155w18cfe43ft819af146357d67f2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Nov 19, 2009 at 05:04:14PM +0800, Jun Nie wrote:
>> > diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
>> > index dbd8cfd..15e64b4 100644
>> > --- a/arch/arm/mach-mmp/ttc_dkb.c
>> > +++ b/arch/arm/mach-mmp/ttc_dkb.c
>> > @@ -14,6 +14,8 @@
>> > ?#include <linux/mtd/mtd.h>
>> > ?#include <linux/mtd/partitions.h>
>> > ?#include <linux/mtd/onenand.h>
>> > +#include <linux/delay.h>
>> > +#include <video/pxa168fb.h>
>> >
>> > ?#include <asm/mach-types.h>
>> > ?#include <asm/mach/arch.h>
>> > @@ -21,6 +23,7 @@
>> > ?#include <mach/addr-map.h>
>> > ?#include <mach/mfp-pxa910.h>
>> > ?#include <mach/pxa910.h>
>> > +#include <mach/gpio.h>
>
> linux/gpio.h please.
>

Rebased to topic/pxa168fb branch of pxa git repository. Change is
minimize LCD reset time of gpio operation.

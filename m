From: vipin.kumar@st.com (Vipin Kumar)
Date: Fri, 1 Oct 2010 11:12:40 +0530
Subject: [PATCH 43/74] ST SPEAr : EMI (Extrenal Memory Interface)
	controller driver
In-Reply-To: <20100906224050.GA8153@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<468bb871e1ce062fbde39f78600b23a896b57a72.1283161023.git.viresh.kumar@st.com>
	<20100906224050.GA8153@game.jcrosoft.org>
Message-ID: <4CA574D0.1020907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2010 4:10 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> diff --git a/arch/arm/mach-spear3xx/emi.c b/arch/arm/mach-spear3xx/emi.c
>> > new file mode 100644
>> > index 0000000..dd5cb8e
>> > --- /dev/null
>> > +++ b/arch/arm/mach-spear3xx/emi.c
>> > @@ -0,0 +1,86 @@
>> > +/*
>> > + * arch/arm/mach-spear3xx/emi.c
>> > + *
>> > + * EMI (External Memory Interface) file
>> > + *
>> > + * Copyright (C) 2010 ST Microelectronics
>> > + * Vipin Kumar<vipin.kumar@st.com>
>> > + *
>> > + * This file is licensed under the terms of the GNU General Public
>> > + * License version 2. This program is licensed "as is" without any
>> > + * warranty of any kind, whether express or implied.
>> > + */
>> > +
>> > +#include <linux/clk.h>
>> > +#include <linux/err.h>
>> > +#include <linux/init.h>
>> > +#include <linux/io.h>
>> > +#include <mach/emi.h>
>> > +
>> > +int __init emi_init(struct platform_device *pdev, unsigned long base,
>> > +             u32 bank, u32 width)
>> > +{
> how about request the memory region
> 
> and use platform device to register the bank ressource instead of define
> 
> it will make it more flexible


Hello Jean,

Sorry for replying late

Since the physmap driver implementation is generic for all the CFI device 
controllers, the driver expects only the actual flash base address in 
resource. Offcourse, the controller needs to be initialized separately.

Moreover, in most of the platforms where physmap driver is being used, the 
controllers are initialized independently. i.e only the NOR flash base 
addresses are passed as resource

examples are 

arch/arm/mach-at91/board-cap9adk.c
arch/arm/mach-ep93xx/adssphere.c
arch/arm/mach-ep93xx/micro9.c

and many more

Regards
Vipin

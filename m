From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 24 Sep 2014 05:47:53 +0000
Subject: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts support
In-Reply-To: <3321146.kBfn28qbNM@wuerfel>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <1411371952-5618-4-git-send-email-jingchang.lu@freescale.com>
 <3321146.kBfn28qbNM@wuerfel>
Message-ID: <a83d5601a26b4e45be5e5016de287287@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>Sent: Tuesday, September 23, 2014 10:54 PM
>To: Lu Jingchang-B35083
>Cc: Guo Shawn-R65073; mark.rutland at arm.com; linux-arm-
>kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu Chen-B46807; Fu
>Chao-B44548
>Subject: Re: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts
>support
>
>On Monday 22 September 2014 15:45:49 Jingchang Lu wrote:
>> @@ -0,0 +1,117 @@
>> +/*
>> + * Copyright 2013-2014 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> +modify
>> + * it under the terms of the GNU General Public License as published
>> +by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>
>Can you change the license so this file is available under both GPL and
>BSD or X11 license?
>
I'd like to add this. Is there any template for my reference? Thanks.

>> +/dts-v1/;
>> +#include "ls1021a.dtsi"
>> +
>> +/ {
>> +       model = "LS1021A TWR Board";
>> +
>> +       aliases {
>> +               enet2_rgmii_phy = &rgmii_phy1;
>> +               enet0_sgmii_phy = &sgmii_phy2;
>> +               enet1_sgmii_phy = &sgmii_phy0;
>> +       };
>> +};
>>
>
>I've never seen alias nodes for mdio devices. What are these used for?
>Shouldn't you use 'phy-handle' properties in the ethernet nodes instead?
>
>	Arnd

The ethernet device nodes already have the phy-handle properties to their mdio nodes.

The alias for PHY nodes here is:
  The ethernet has two kind of PHY interface, one is SGMII, and the other is RGMII,
The selection is done by the reset configuration word(RCW), so Phy-handle properties
should be change properly to reflecting the PHY interface selection. This is done
by fixing up dtb in u-boot before booting the kernel. Thus the alias for PHY nodes
is added here for fdt finding the PHY nodes easily.

Best Regards,
Jingchang

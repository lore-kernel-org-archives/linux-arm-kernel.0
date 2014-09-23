From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 16:54:19 +0200
Subject: [PATCHv4 3/6] ARM: dts: Add initial LS1021A TWR board dts support
In-Reply-To: <1411371952-5618-4-git-send-email-jingchang.lu@freescale.com>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <1411371952-5618-4-git-send-email-jingchang.lu@freescale.com>
Message-ID: <3321146.kBfn28qbNM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014 15:45:49 Jingchang Lu wrote:
> @@ -0,0 +1,117 @@
> +/*
> + * Copyright 2013-2014 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

Can you change the license so this file is available under both GPL and
BSD or X11 license?

> +/dts-v1/;
> +#include "ls1021a.dtsi"
> +
> +/ {
> +       model = "LS1021A TWR Board";
> +
> +       aliases {
> +               enet2_rgmii_phy = &rgmii_phy1;
> +               enet0_sgmii_phy = &sgmii_phy2;
> +               enet1_sgmii_phy = &sgmii_phy0;
> +       };
> +};
> 

I've never seen alias nodes for mdio devices. What are these used for?
Shouldn't you use 'phy-handle' properties in the ethernet nodes instead?

	Arnd

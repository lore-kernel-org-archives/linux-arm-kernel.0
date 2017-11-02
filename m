From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 2 Nov 2017 11:28:55 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <20171102112041.GW9463@n2100.armlinux.org.uk>
References: <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102112041.GW9463@n2100.armlinux.org.uk>
Message-ID: <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 02, 2017, Russell King - ARM Linux wrote:
> The compiler is only involved for the C pre-processor front-end.  It's
> not involved in parsing the resulting assembly - as far as gcc is
> concerned, it could be forth in the post-processed file.
> 
> GCC will then pass the post-processed output to binutils 'as' to do the
> actual assembly, and that's what should complain.

Oops, I meant to show this:

$ arm-linux-gnueabihf-as -version
GNU assembler (Linaro_Binutils-2017.01) 2.25.2 Linaro 2016_02
Copyright (C) 2014 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `arm-linux-gnueabihf'.


> So, as far as ARM assembly in the Linux kernel goes, all constants must
> be preceded by # whether or not binutils requires it - no exceptions.
> Please always test assembly changes with a binutils version that is not
> gratuitously broken!

Somewhat ironic since Nicolas works for Linaro.


Chris

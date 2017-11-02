From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 2 Nov 2017 15:25:59 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <18e5317b-c3a4-1b6c-5bb1-154e5a0971d2@arm.com>
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
 <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
 <18e5317b-c3a4-1b6c-5bb1-154e5a0971d2@arm.com>
Message-ID: <SG2PR06MB11655DC53E94BD4C18F7B32E8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 02, 2017 1, Robin Murphy wrote:
> >
> > They all fail, including the version that looks like the one you have.
> 
> Note that for UAL syntax, GAS follows the ARM ARM recommendation and
> considers the '#' on immediate values optional everywhere. I'm going to
> hazard a guess that Chris might be building a Thumb-2 kernel or somehow
> otherwise has ARM_ASM_UNIFIED turned on.

Correct.

$ grep THUMB2 .config
CONFIG_THUMB2_KERNEL=y

$ grep UNIFIED .config
CONFIG_ARM_ASM_UNIFIED=y

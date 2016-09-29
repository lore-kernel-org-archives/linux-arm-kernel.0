From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 29 Sep 2016 18:44:12 +0800
Subject: [PATCH 00/10] ARM: dts: berlin: fix dtc warnings
In-Reply-To: <57EC1CA5.2030102@gmail.com>
References: <20160906084013.2887-1-jszhang@marvell.com>
 <57EC1CA5.2030102@gmail.com>
Message-ID: <20160929184412.7c535749@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wed, 28 Sep 2016 21:40:21 +0200 Sebastian Hesselbarth wrote:

> On 06.09.2016 10:40, Jisheng Zhang wrote:
> > This is a clean up series to fix berlin arm platforms dtc warnings.
> > Firstly we remove skeleton.dtsi inclusion. Then add missing unit name
> > of /soc node and /memory node. Lastly, we fix regulators' name
> >
> > Jisheng Zhang (10):
> >    ARM: dts: berlin2q: Remove skeleton.dtsi inclusion
> >    ARM: dts: berlin2cd: Remove skeleton.dtsi inclusion
> >    ARM: dts: berlin2: Remove skeleton.dtsi inclusion
> >    ARM: dts: berlin2q: Add missing unit name to /soc node
> >    ARM: dts: berlin2cd: Add missing unit name to /soc node
> >    ARM: dts: berlin2: Add missing unit name to /soc node
> >    ARM: dts: berlin2q-marvell-dmp: add missing unit name to /memory node
> >    ARM: dts: chromecast: add missing unit name to /memory node  
> 
> Jisheng,
> 
> Applied the 8 patches above.
> 
> >    ARM: dts: sony-nsz-gs7: add missing unit name to /memory node  
> 
> I didn't receive this one and could not find it online.
> I recreated the patch by using the chromecast patch above, so
> applied.
> 
> >    ARM: dts: berlin2q-marvell-dmp: fix regulators' name  
> 
> I have no clue what it should be fixed to.

DTC will complain with W=1:

Warning (unit_address_vs_reg): Node /regulators/regulator at 0 has a unit
name, but no reg property

This patch tries to fix that warning.

Thanks,
Jisheng

> 
> Sebastian
> 
> >   arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        |  2 +-
> >   arch/arm/boot/dts/berlin2.dtsi                    |  5 +++--
> >   arch/arm/boot/dts/berlin2cd-google-chromecast.dts |  2 +-
> >   arch/arm/boot/dts/berlin2cd.dtsi                  |  5 +++--
> >   arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 12 ++++++------
> >   arch/arm/boot/dts/berlin2q.dtsi                   |  6 +++---
> >   6 files changed, 17 insertions(+), 15 deletions(-)
> >  
> 

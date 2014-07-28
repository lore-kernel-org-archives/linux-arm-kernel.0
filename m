From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 13:02:47 +0200
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <78788908-DDB5-46F8-83C1-FAE312D7BFB2@perenite.com>
References: <1406418436-61452-1-git-send-email-yahoo@perenite.com>
 <5442226.1WCY4fjGCy@wuerfel>
 <78788908-DDB5-46F8-83C1-FAE312D7BFB2@perenite.com>
Message-ID: <6028388.mjACYPxFta@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 12:50:47 Benoit Masson wrote:
> > 
> > It should still list both "marvell,mv78230-i2c" and "marvell,mv64xxx-i2c",
> > as the generic name may not be enough to describe the register layout
> > correctly.
> 
> I tend to disagree since the dts include the armada-xp.dtsi, which already declare
> 
> "i2c0: i2c at 11000 {
>                                 compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>                                 reg = <0x11000 0x100>;
>                         };
> "
> 
> I tested the dts on the device and it does inherits the i2c declaration, did I miss something here ?
> 

Inheriting from armada-xp.dtsi is fine, but if you manually set
"marvell,mv64xxx-i2c", that will override the old setting
and drop the "marvell,mv78230-i2c" part, which is bad because
it may break things later if it turns out that the mv78230
variant is not completely compatible with the old
mv64xxx variant.

	Arnd

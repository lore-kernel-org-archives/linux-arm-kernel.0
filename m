From: benoitm@perenite.com (Benoit Masson)
Date: Mon, 28 Jul 2014 12:50:47 +0200
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <5442226.1WCY4fjGCy@wuerfel>
References: <1406418436-61452-1-git-send-email-yahoo@perenite.com>
 <20140727015244.GA31974@lunn.ch> <5442226.1WCY4fjGCy@wuerfel>
Message-ID: <78788908-DDB5-46F8-83C1-FAE312D7BFB2@perenite.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Le 28 juil. 2014 ? 10:49, Arnd Bergmann <arnd@arndb.de> a ?crit :

> On Sunday 27 July 2014 03:52:44 Andrew Lunn wrote:
>> Hi Benoit

Hi Arnd,

>> 
>>> +                     i2c at 11000 {
>>> +                             compatible = "marvell,mv78230-a0-i2c",
>>> +                                     "marvell,mv64xxx-i2c";
>> 
>> The point of my patches is that you don't need the
>> "marvell,mv78230-a0-i2c". It will work out at runtime if the SoC is A0
>> stepping and automatically enable the workaround. Please test with
>> only "marvell,mv64xxx-i2c";
>> 
> 
> It should still list both "marvell,mv78230-i2c" and "marvell,mv64xxx-i2c",
> as the generic name may not be enough to describe the register layout
> correctly.

I tend to disagree since the dts include the armada-xp.dtsi, which already declare

"i2c0: i2c at 11000 {
				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
				reg = <0x11000 0x100>;
			};
"

I tested the dts on the device and it does inherits the i2c declaration, did I miss something here ?

Benoit

> 	Arnd

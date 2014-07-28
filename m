From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 10:49:39 +0200
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <20140727015244.GA31974@lunn.ch>
References: <1406418436-61452-1-git-send-email-yahoo@perenite.com>
 <20140727015244.GA31974@lunn.ch>
Message-ID: <5442226.1WCY4fjGCy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 July 2014 03:52:44 Andrew Lunn wrote:
> Hi Benoit
> 
> > +                     i2c at 11000 {
> > +                             compatible = "marvell,mv78230-a0-i2c",
> > +                                     "marvell,mv64xxx-i2c";
> 
> The point of my patches is that you don't need the
> "marvell,mv78230-a0-i2c". It will work out at runtime if the SoC is A0
> stepping and automatically enable the workaround. Please test with
> only "marvell,mv64xxx-i2c";
> 

It should still list both "marvell,mv78230-i2c" and "marvell,mv64xxx-i2c",
as the generic name may not be enough to describe the register layout
correctly.

	Arnd

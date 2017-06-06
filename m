From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Jun 2017 10:57:41 +0100
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <20170606113626.197efbf7@free-electrons.com>
References: <20170605200107.7692-1-marc.zyngier@arm.com>
 <20170606110234.239d2c4a@free-electrons.com>
 <20170606110603.2dafb7ed@free-electrons.com>
 <87h8ztjwz0.fsf@arm.com>
 <20170606113626.197efbf7@free-electrons.com>
Message-ID: <20170606095741.GG4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 11:36:26AM +0200, Thomas Petazzoni wrote:
> Side note: I don't understand this change from "phy" to "phy-handle".
> It really doesn't make sense to me to encode the type of the property
> in the name of the property. Are we going to use:

ePAPR 1.1 has specified phy-handle, which as the binding document says
is the preferred version (probably because it's in ePAPR as the official
name of the property.)

We've ended up with "phy" and "phy-handle" because there was never a
central binding document for ethernet devices until 2014, so drivers
randomly picked between the two property names.  Which one should be
used is driver dependent, since drivers parse this property.  Many
drivers parse just one of the names and not the other, so you have to
use the right one for the driver.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

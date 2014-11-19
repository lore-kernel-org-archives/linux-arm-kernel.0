From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Nov 2014 16:47:13 +0000
Subject: [PATCH] ARM: dts: dove: add DT LCD controllers
In-Reply-To: <20141119174050.122a0cc0@armhf>
References: <E1Xr3Ur-0005Qx-Fx@rmk-PC.arm.linux.org.uk>
 <20141119174050.122a0cc0@armhf>
Message-ID: <20141119164713.GJ4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 05:40:50PM +0100, Jean-Francois Moine wrote:
> On Wed, 19 Nov 2014 11:32:29 +0000
> Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > +			lcd1: lcd-controller at 810000 {
> > +				compatible = "marvell,dove-lcd";
> > +				reg = <0x810000 0x1000>;
> > +				interrupts = <46>;
> > +				status = "disabled";
> > +			};
> 
> The I/O range of the LCDs is only 0x1c8. Why do you set it 0x1000?

Actually, a more correct value would be 0x10000, if you read table 145.
Yes, the device may onlny have documented registers from 0x84 to 0x1c8,
but that isn't to say that we should say that the device resources
start at 0x810084 and have a size of 0x144, when the bus level decodes
a 64K chunk of memory.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

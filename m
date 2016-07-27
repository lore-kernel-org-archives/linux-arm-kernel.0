From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jul 2016 12:26:41 +0200
Subject: [PATCH] ARM: dts: armada388-clearfog: number LAN ports properly
In-Reply-To: <20160727102120.GV1041@n2100.armlinux.org.uk> (Russell King's
 message of "Wed, 27 Jul 2016 11:21:20 +0100")
References: <E1bLWIh-0001ZK-Ai@rmk-PC.armlinux.org.uk>
 <20160708152616.GF8426@lunn.ch> <87vazro02y.fsf@free-electrons.com>
 <20160727102120.GV1041@n2100.armlinux.org.uk>
Message-ID: <87r3afnzq6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On mer., juil. 27 2016, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Wed, Jul 27, 2016 at 12:19:01PM +0200, Gregory CLEMENT wrote:
>> Hi,
>>  
>>  On ven., juil. 08 2016, Andrew Lunn <andrew@lunn.ch> wrote:
>> 
>> > On Fri, Jul 08, 2016 at 02:58:39PM +0100, Russell King wrote:
>> >> Currently, the ports as seen from the rear number as:
>> >> 
>> >> 	eth0 sfp lan5 lan4 lan3 lan2 lan1 lan6
>> >> 
>> >> which is illogical - this came about because the rev 2.0 boards have the
>> >> LEDs on the front for the DSA switch (lan5-1) reversed.  Rev 2.1 boards
>> >> fixed the LED issue, and the Clearfog case numbers the lan ports
>> >> increasing from left to right.
>> >> 
>> >> Maintaining this illogical numbering causes confusion, with reports that
>> >> "my link isn't coming up" and "my connection negotiates 10base-Half"
>> >> both of which are due to people thinking that the port next to the SFP
>> >> is lan1.
>> >> 
>> >> Fix this by renumbering the ports to match people's expectations.
>> >> 
>> >> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> >
>> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> 
>> I missed this patch, but I now applied it on mvebu/dt-4.9
>
> It would be much better to get it into 4.8-rc so that we don't spread
> the port renumbering over a large range of kernels, as well as forcing
> vendors to carry patches like this to fix problems.

I can move it to the mvebu/fixes branch, it is not too late. Also what
about to apply it on the stable kernel?

Gregory

>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

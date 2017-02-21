From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Feb 2017 11:12:46 +0100
Subject: [PATCHv2 net-next 01/16] dt-bindings: net: update Marvell PPv2
 binding for PPv2.2 support
In-Reply-To: <20170214152503.602878cb@free-electrons.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170103201842.hdg2uzzesog2jund@rob-hp-laptop>
 <20170202175650.1fc06c2d@free-electrons.com>
 <20170203164808.GD27312@n2100.armlinux.org.uk>
 <20170214152503.602878cb@free-electrons.com>
Message-ID: <20170221111246.2718c21a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 14 Feb 2017 15:25:03 +0100, Thomas Petazzoni wrote:

> I'll try to get some more information about this, but I suspect this is
> one case where we don't yet fully understand how all the HW works and
> what all registers are doing, so it's hard to do a perfect DT binding
> from day 1.

So I've looked into this more closely, and after drawing a diagram of
all the register areas, I came up with a much more reduced area, with
only networking related registers: starting at 0x129000 for a size of
0xb000. So now the DT node looks like this:

+                       cpm_ethernet: ethernet at 0 {
+                               compatible = "marvell,armada-7k-pp22";
+                               reg = <0x0 0x100000>, <0x129000 0xb000>;

This will be part of my next iteration.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

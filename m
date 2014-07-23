From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 24 Jul 2014 00:26:40 +0200
Subject: [PATCH 1/2] Added dts defintion for Lenovo ix4-300d nas
In-Reply-To: <9AE6F1AD-9296-47E9-91E2-9E34AA48EBB4@perenite.com>
References: <1406117232-5962-1-git-send-email-yahoo@perenite.com>
 <20140723134534.GF23220@titan.lakedaemon.net>
 <20140723141443.GC2856@lunn.ch>
 <47823826-CDE8-47D2-B1B6-B688118CF985@perenite.com>
 <20140723164958.GH2856@lunn.ch>
 <9AE6F1AD-9296-47E9-91E2-9E34AA48EBB4@perenite.com>
Message-ID: <20140723222640.GA28485@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Both phy are :
> marvell,88e1318

I don't have the datasheet for this specific phy model, but i do have
the datasheet for another similar phy.
 
> example of a minimal reg write that lead MPP24 to shutdown instead
> of rebooting on original BSP driver

> XXXXX BasicInit

I'm assuming regOffs is decimal, and data is hex?

> phyAdr 0: regOffs: 16 data: 3

Copper Specific control register. 3 means Polarity Reversal Disable &
Jabber function disable.

> phyAdr 0: regOffs: 10 data: 830

Reg 10 is the 1000BASE-T Status register, which is read only!

So this is not making much sense. Are we missing some changes to the
page register? Register 16 of page 3 is the LED control register.

     Andrew

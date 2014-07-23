From: benoitm@perenite.com (Benoit Masson)
Date: Wed, 23 Jul 2014 17:52:57 +0200
Subject: [PATCH 1/2] Added dts defintion for Lenovo ix4-300d nas
In-Reply-To: <20140723141443.GC2856@lunn.ch>
References: <1406117232-5962-1-git-send-email-yahoo@perenite.com>
 <20140723134534.GF23220@titan.lakedaemon.net> <20140723141443.GC2856@lunn.ch>
Message-ID: <47823826-CDE8-47D2-B1B6-B688118CF985@perenite.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew I've taken your comment into account, yet for the PHY init comment, see my answer below.

Le 23 juil. 2014 ? 16:14, Andrew Lunn <andrew@lunn.ch> a ?crit :
> 
>>> +	/* warning: you need both eth1 & 0 to be initialize for poweroff to shutdown otherwise it reboots */
> 
> What do you mean by initialized? Driver loaded? Interface up? 
Well actually the PHY need to be initialized (at least 1 mII reg written), which from marvel LSP driver always occurs, while it doesn't with mainline PHY driver (drivers/net/phy/marvell.c), so the only simple way I found to have at least one PHY reg on both interface written is to have both eth up at OS config level.

Probably the best option would be to have a reg-init = <reg offset value> on both phy dts definition but the current armada mii doesn't support this dts config...

> 
>> This is a great first version
> 
> I agree with Jason, well done.
> 
Thanks !
>  Andrew

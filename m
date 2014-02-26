From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Feb 2014 21:22:22 +0100
Subject: [PATCH] net: phy: add suspend_halted module param
In-Reply-To: <CAGVrzcb5k1JUPo0kvMdPJLCkWHb9qfHfDif08ud5ydKiKBwdHQ@mail.gmail.com>
References: <1393174719-20806-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224191554.GC29288@lunn.ch> <530D1B7C.2090506@gmail.com>
 <20140226182117.GB14907@lunn.ch>
 <CAGVrzcYUfq84ryVET9qNJvyFCnhFdU4c0fOHbNN4eE8_w6qsAQ@mail.gmail.com>
 <20140226191009.GC14907@lunn.ch>
 <CAGVrzcb5k1JUPo0kvMdPJLCkWHb9qfHfDif08ud5ydKiKBwdHQ@mail.gmail.com>
Message-ID: <20140226202222.GD14907@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The only case we need to handle is when the interface is brought down,
> suspend_halted=true will also power down the PHY, you reboot into
> u-boot, and you attempt a network boot right after that, in that case
> the PHY interface is still powered down and this does not work.

Correct. And since my device uses dhclient, the interface is always
put down on reboot when it releases the lease. 
 
> That could be worked around by putting the interface up again before
> you reboot into u-boot right, that specific logic being gated by
> reading the board model. Agreed, you need to duplicate that workaround
> in all affected user-space....

I wonder how many other systems are broken? Are we considering this a
regression? Should this feature to turned off by default, and a sysfs
knob used to enable it? That is the safe option.

     Andrew

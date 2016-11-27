From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Nov 2016 23:08:46 +0100
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Add 88E6176 device tree support
In-Reply-To: <9500470d-09c3-3ecb-994b-3d108bffc99e@suse.de>
References: <1480280279-9552-1-git-send-email-afaerber@suse.de>
 <1480280279-9552-2-git-send-email-afaerber@suse.de>
 <20161127212709.GD13318@lunn.ch>
 <9500470d-09c3-3ecb-994b-3d108bffc99e@suse.de>
Message-ID: <20161127220846.GH13318@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This driver already supports nearly 30 different Marvell switch
> > models. Please document why the marvell,mv88e6176 is special and why
> > it needs its own compatible string when the others don't.
> 
> I don't understand.

Think about what i said. Why does the 6176 need its own compatible
string, when the two 6352s and the 6165 on the zii-devel-b don't have
one? And the DIR 665 has a 6171, which does not have a compatible
string of its own. The clearfog actually has a 6176, and it seems to
work fine without a compatible string.

> You as driver author should know that the .data pointer is vital to your
> driver

Exactly, so if i ask why is it needed, maybe you should stop and think
for a while.

> you even recently accepted another model that conflicted with
> my patch.

And think about that also, and you will find the 6390 family, who's
first device is 6190, is not compatible with the 6085, and so needs a
different compatible string.

	  Andrew

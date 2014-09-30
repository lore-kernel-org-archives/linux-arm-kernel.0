From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 30 Sep 2014 13:09:34 +0000
Subject: [PATCH v5 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <20140929.155200.2231132602322345812.davem@davemloft.net>
References: <1411667317-1163-1-git-send-email-santosh.shilimkar@ti.com>
 <1411667317-1163-3-git-send-email-santosh.shilimkar@ti.com>
 <20140929.155200.2231132602322345812.davem@davemloft.net>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D174A1012@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Thu, 25 Sep 2014 13:48:36 -0400
> 
> > +static inline int gbe_phy_link_status(struct gbe_slave *slave)
> > +{
> > +	if (!slave->phy)
> > +		return 1;
> > +
> > +	if (slave->phy->link)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> 
> Please use 'bool' as the return type and return 'true' or 'false'.

That function body could also be just:
	return !slave->phy && slave->phy->link;
which might be more readable if directly coded.

I also wonder if slave>phy can actually be NULL?
If it can be under unusual circumstances it might be worth
assigning the address of a dummy 'phy' structure so that the
tests can all be removed.

	David

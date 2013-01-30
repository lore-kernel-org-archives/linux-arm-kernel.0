From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 30 Jan 2013 16:10:35 -0700
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130130232836.1b1fd89b@skate>
References: <20130129055508.GA3339@obsidianresearch.com>
 <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
 <20130129184157.GA29274@obsidianresearch.com>
 <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
 <20130129191853.GB29274@obsidianresearch.com>
 <CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com>
 <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
 <20130130103501.1873d39c@skate>
 <CAErSpo5NTyrHv8AQkw3hYpJRiZsk1HKHP3jP_MMpEVVhCgjKYg@mail.gmail.com>
 <20130130232836.1b1fd89b@skate>
Message-ID: <20130130231035.GB7395@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 11:28:36PM +0100, Thomas Petazzoni wrote:

> > It looks like your current system doesn't support trees below the
> > bridges, but hopefully we can make it so the generic enumeration
> > algorithms still work.
> 
> In practice, in our situation, there isn't a tree below the bridge.
> There is one single device. I'd prefer to not implement features that I
> cannot effectively test, and let the implementation of those additional
> features to whoever will need them, and therefore be able to test
> them.

Agreed it is hard to test, but be aware that any system that has PCI-E
slots can host an add-in card that has a bridge on it. These are midly
common in some areas like high port count ethernet cards.

If you aren't going to attempt the implementation then a really big
FIXME that the config access routing is not correct and needs to be
based on the bus range assigned to the bridge would be friendly :)

Jason

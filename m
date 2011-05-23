From: kristoffer@gaisler.com (Kristoffer Glembo)
Date: Mon, 23 May 2011 11:37:04 +0200
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>	<20110519233958.GB18181@ponder.secretlab.ca>	<4DD66B8A.5040404@gmail.com>	<201105201621.03801.arnd@arndb.de>
	<4DD68614.6090209@gmail.com>	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
	<BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
Message-ID: <4DDA2AC0.1060406@gaisler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Grant Likely wrote:
> In the case we're talking about the bus really is an AMBA bus, and all
> the devices on it are in some sense real amba devices.  The problem is
> that not all of the devices on the bus implement peripheral ID
> registers or other mechanisms that good upstanding AMBA devices are
> expected to have.  


Before we go hardware bashing of non primecell AMBA devices I would just
want to point out that the primecell stuff is not part of the AMBA specification.

So the "amba bus" should really have a way of marking which devices are primecell
devices instead of assuming this.

We (Aeroflex Gaisler) use an AMBA bus on our LEON SPARC chips but don't have any primecells 
devices. We went the of_platform_driver route after concluding that the AMBA bus in Linux is 
really not an AMBA bus at all. Our bus is fully probable though as all information about the 
present devices are memory mapped in a "plug and play" area.

On the other hand, there is not much point of an AMBA bus driver which does nothing more than
the platform driver. But AMBA is really a misnomer in this case.

/Kristoffer

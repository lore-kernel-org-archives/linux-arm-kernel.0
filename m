From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Feb 2014 20:13:05 +0100
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140218184542.GA22004@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <1663692.UxtD9eTEBL@wuerfel> <20140218184542.GA22004@obsidianresearch.com>
Message-ID: <1507733.rhSv1eYnEK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 February 2014 11:45:42 Jason Gunthorpe wrote:
> 
> > Do we even need stable domain numbers? If we do, aliases sound fine.
> > A more complex method would be to sort them by MMIO window address
> > or perhaps by phandle.
> 
> PCI ordering has been a bane in the past on x86, so I think stable
> domain numbers is certainly desirable. Particularly since the domain
> number may be influenced by module load order  Alises followed by
> sorting by phandle sounds great to me.

Ok, makes sense. Let's make sure we come up with a stable numbering
enforced by DT then, and warn when it's not there (or refuse to
work even).

	Arnd

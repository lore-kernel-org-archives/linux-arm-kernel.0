From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 09:35:05 +0100
Subject: [PATCH 4/4] ARM: keystone: Use dma-ranges for dma_pfn_offset
 configuration
In-Reply-To: <530BBBB8.3020607@ti.com>
References: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
 <5593544.ET3nngKczF@wuerfel> <530BBBB8.3020607@ti.com>
Message-ID: <13859197.4VXqXcWsT4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 February 2014 16:38:00 Santosh Shilimkar wrote:
> > I also wonder if this shouldn't be in ARM architecture wide code
> > rather than platform code. Unfortunately it can't be in drivers/base
> > since the offset is stored in an ARM specific location.
> > 
> Notifier callback is in mach code mainly because platform's might have to
> do custom things here. Like setting up the coherent masters,
> populating the dma_pfn_offset or populating custom dma_ops etc.
> As such the in these callbacks is not much and I see only
> couple of machines using it.

Yes, but since "dma-ranges" is a standard property, I think we should
provide a generic implementation so other platforms don't have to
copy one. Most platforms today are never cache-coherent and have
a trivial mapping, so they don't need this function, but I suppose
the case you have is getting more popular. I think shmobile is in
exactly the same position with their new r-car parts for instance.

	Arnd

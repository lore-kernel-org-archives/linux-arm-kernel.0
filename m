From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Jul 2013 08:49:58 +0900
Subject: [PATCH v4 0/3]  ARM: shmobile: lager: enable Ether
In-Reply-To: <7990652.CKWzcoj3FL@avalon>
References: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
 <7990652.CKWzcoj3FL@avalon>
Message-ID: <20130716234958.GB30268@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 11:42:12AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 01 July 2013 16:20:31 Simon Horman wrote:
> > Hi,
> > 
> > this short series enables the on-board ethernet
> > of the r8a7790 SoC for on lager board.
> > 
> > It has a run-time dependency on
> > "sh_eth: add support for r8a7790 SoC"
> > 
> > It has been built on top of renesas-next-20130701.
> 
> Do you plan to respin this series on top of your latest devel branch ? I've 
> quickly rebased it and now get receive FIFO overflows when booting over NFS, 
> followed by the kernel disabling the sh-eth IRQ.

I am planning to respin it and the driver changes once
net-next re-opens. Which I am expecting to be next week.

> > Simon Horman (3):
> >   ARM: shmobile: r8a7790: add Ether support
> >   ARM: shmobile: lager: enable Ether
> >   ARM: shmobile: lager: enable nfsroot in DTS
> > 
> >  arch/arm/boot/dts/r8a7790-lager.dts           |  2 +-
> >  arch/arm/mach-shmobile/board-lager.c          | 24 ++++++++++++++++++++++++
> > arch/arm/mach-shmobile/clock-r8a7790.c        |  4 ++++
> >  arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
> >  arch/arm/mach-shmobile/setup-r8a7790.c        | 14 ++++++++++++++
> >  5 files changed, 46 insertions(+), 1 deletion(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 16 Jul 2013 11:42:12 +0200
Subject: [PATCH v4 0/3]  ARM: shmobile: lager: enable Ether
In-Reply-To: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
References: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <7990652.CKWzcoj3FL@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Monday 01 July 2013 16:20:31 Simon Horman wrote:
> Hi,
> 
> this short series enables the on-board ethernet
> of the r8a7790 SoC for on lager board.
> 
> It has a run-time dependency on
> "sh_eth: add support for r8a7790 SoC"
> 
> It has been built on top of renesas-next-20130701.

Do you plan to respin this series on top of your latest devel branch ? I've 
quickly rebased it and now get receive FIFO overflows when booting over NFS, 
followed by the kernel disabling the sh-eth IRQ.

> Simon Horman (3):
>   ARM: shmobile: r8a7790: add Ether support
>   ARM: shmobile: lager: enable Ether
>   ARM: shmobile: lager: enable nfsroot in DTS
> 
>  arch/arm/boot/dts/r8a7790-lager.dts           |  2 +-
>  arch/arm/mach-shmobile/board-lager.c          | 24 ++++++++++++++++++++++++
> arch/arm/mach-shmobile/clock-r8a7790.c        |  4 ++++
>  arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
>  arch/arm/mach-shmobile/setup-r8a7790.c        | 14 ++++++++++++++
>  5 files changed, 46 insertions(+), 1 deletion(-)

-- 
Regards,

Laurent Pinchart

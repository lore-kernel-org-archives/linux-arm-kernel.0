From: ben@simtec.co.uk (Ben Dooks)
Date: Mon, 04 Jan 2010 11:55:24 +0900
Subject: [PATCH 0/4] Add s3c64xx SROM support and setup SMDK nCS1 for
	Ethernet
In-Reply-To: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
References: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
Message-ID: <4B41589C.8090009@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Green wrote:
> The following series adds platform defines for s3c64xx SROM unit,
> and uses it to configure nCS1 in the SMDK mach- file so the ethernet
> works regardless of what the bootloader may or may not have done.
> 
> It also adds a comment about how the SMDK must be physically
> configured to allow the Ethernet to work and removes a magic
> constant address.

Looks ok, will look at merging into my next-s3c64xx tree at
somepoint soon.

> ---
> 
> Andy Green (4):
>       smdk6410-comment-ethernet-prerequisites.patch
>       smdk6410-add-chipselect-setup.patch
>       s3c64xx-add-srom-physical-virtual-mapping.patch
>       s3c64xx-introduce-srom-registers.patch
> 
> 
>  arch/arm/mach-s3c6400/include/mach/map.h       |   14 ++++++
>  arch/arm/mach-s3c6410/mach-smdk6410.c          |   37 ++++++++++++++-
>  arch/arm/plat-s3c64xx/cpu.c                    |    5 ++
>  arch/arm/plat-s3c64xx/include/plat/regs-srom.h |   59 ++++++++++++++++++++++++
>  4 files changed, 113 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/plat-s3c64xx/include/plat/regs-srom.h
> 

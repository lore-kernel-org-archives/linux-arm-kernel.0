From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Jan 2014 10:14:04 -0500
Subject: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
In-Reply-To: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20140114151404.GN19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

On Tue, Jan 14, 2014 at 03:50:04PM +0100, Simon Guinot wrote:
> Hello,
> 
> This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
> SoCs: once a disk is removed from a SATA port, then the re-plug events
> are not detected by the sata_mv driver.
> 
> This should be applied to the -stable kernels 3.10 and onwards. 

Please add a 'Fixes: <commit-hash> (oneline)' tag below the Cc: stable
tags.  It looks like the sata_mv binding and the Armada 370 DT booting
were both introduced in v3.6, so I would probably use:

Fixes: 9ae6f740b49f (arm: mach-mvebu: add support for Armada 370 and Armada XP with DT)

Is there a specific reason you say v3.10?

Once you've incorporated Gregory's comments,

Acked-by: Jason Cooper <jason@lakedaemon.net>

> Lior Amsalem (1):
>   ata: sata_mv: fix disk hotplug for Armada 370/XP SoCs
> 
> Simon Guinot (2):
>   ata: sata_mv: introduce compatible string "marvell,armada-370-xp-sata"
>   ARM: mvebu: update the SATA compatible string for Armada 370/XP
> 
>  Documentation/devicetree/bindings/ata/marvell.txt |  2 +-
>  arch/arm/boot/dts/armada-370-xp.dtsi              |  2 +-
>  drivers/ata/sata_mv.c                             | 25 +++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)

Tejun,

I see no point to breaking up this series only to have both pieces end
up in stable.  Are you ok with taking the whole thing?

thx,

Jason.

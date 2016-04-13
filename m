From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 13 Apr 2016 17:27:47 +0200
Subject: [PATCH 00/16] mtd: nand: sunxi: various improvements/fixes
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160413172747.5b4a4502@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  7 Mar 2016 17:18:17 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi,
> 
> This patchset aims at fixing a few minor bugs, and improving performances
> of NAND accesses going through the sunxi NAND controller.
> 
> Note that patch 5 exports functions provided by the core which are needed
> in patch 6 to still support raw OOB accesses. Other patches are just
> fixes or improvements only touching the sunxi driver itself.
> 
> Here are the main improvements:
> - queue CLE/ALE requests instead of forcing the controller to issue each
>   cmd and address cycle separately
> - benefit from ECC correction on protected OOB bytes
> - use polling instead of interrupt-based waiting (avoid scheduling
>   overhead for short wait period)

I'm applying this series since it only touches the sunxi NAND driver,
and I don't expect to have any external reviews :).

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 8 Oct 2012 06:08:08 +0000
Subject: [PATCH v2 00/14] OMAP-GPMC related cleanup for common zImage
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9F7B0A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,

On Mon, Oct 08, 2012 at 11:05:56, Mohammed, Afzal wrote:

> This series cleans up omap-gpmc related code so that omap can
> be a part of common zImage.

> This series moves gpmc.h from plat-omap/include/plat to mach-omap2
> so that header file is local.

> Patches 7 & 8 cleans up the already moved platform data header files
> to contain only platform data. Also gpmc-nand information is moved
> to nand platform data header.
> 
> Patches 9-13 makes nand driver independent of gpmc header file
> 
> And the final patch localizes gpmc header.

BCH[48] support that you have added on OMAP using gpmc exported
symbols has been changed such that nand driver now takes care
of BCH support without relying on gpmc exported symbols.

This is more or less a cut & paste of your implementation, which was
necessitated now due to common ARM zImage cleanup w.r.t header files.

Please verify that BCH[48] works as earlier with this series.

Regards
Afzal

> This series is available
>         @ git://gitorious.org/x0148406-public/linux-kernel.git gpmc-czimage-v2
> and is based on
>         linux-next (next-20121005)
> and is dependent on
> 	http://marc.info/?l=linux-omap&m=134945131602622&w=2

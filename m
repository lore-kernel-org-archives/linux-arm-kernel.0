From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jul 2012 14:50:17 +0200
Subject: [PATCH 0/3] ARM: dts: dove: Basic devicetree support for Marvell
 Dove
In-Reply-To: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
Message-ID: <20120703125017.GB17534@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 02:34:23PM +0200, Sebastian Hesselbarth wrote:
> This patch series add very basic devicetree support for Marvell Dove.
> It is based on Kirkwood dts and therefore supports uart and rtc by
> dt only.
> 
> The patches have not been tested on neither Dove-DB nor CM-A510 but
> on SolidRun Cubox that is not supported by mainline kernel, yet.

Hi Sebastian

> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> 
> Sebastian Hesselbarth (3):
>   ARM: dts: dove: Add devicetree descriptors
>   ARM: dts: dove: Add devicetree-based board setup
>   ARM: dts: dove: Integrate devicetree support
> 
>  arch/arm/boot/dts/dove-cm-a510.dtsi |   27 ++++++++++
>  arch/arm/boot/dts/dove-dove-db.dtsi |   27 ++++++++++
>  arch/arm/boot/dts/dove.dtsi         |   55 +++++++++++++++++++++
>  arch/arm/mach-dove/Kconfig          |   20 ++++++++
>  arch/arm/mach-dove/Makefile         |    4 ++
>  arch/arm/mach-dove/Makefile.boot    |    3 ++
>  arch/arm/mach-dove/board-cm-a510.c  |   86 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-dove/board-dove-db.c  |   92 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-dove/board-dt.c       |   73 +++++++++++++++++++++++++++
>  arch/arm/mach-dove/common.c         |   17 ++++---
>  arch/arm/mach-dove/common.h         |   25 ++++++++++
>  12 files changed, 444 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
>  create mode 100644 arch/arm/boot/dts/dove-dove-db.dtsi

These two should be dts files, not dtsi. They are not include files.

I also noticed a few mrvl in the compatibility strings. We have
decided to use marvell.

	Andrew

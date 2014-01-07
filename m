From: horms@verge.net.au (Simon Horman)
Date: Tue, 7 Jan 2014 10:39:36 +0900
Subject: [PATCH v3 0/4] Lager and Koelsch reference serial port support
In-Reply-To: <1386767664-20113-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386767664-20113-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20140107013936.GF2196@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 02:14:20PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> This patch set implements serial port support for the Lager reference board.
> 
> The code is available in my git tree at
> 
>         git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/serial/boards
> 
> The patches are based on top of the "[PATCH 00/47] sh-sci updates for v3.14"
> and "[PATCH v3 00/15] Lager and Koelsch multiplatform support" patch series.

Hi Laurent, Hi Magnus,

I have marked this series as deferred, but to be honest
I don't quite recall what we decided to do with it.

> 
> Changes compared to v2:
> 
> - Added Koelsch support
> 
> Changes compared to v1:
> 
> - Removed early debugging support as it requires more work before being
>   mainlined
> 
> Laurent Pinchart (4):
>   ARM: shmobile: r8a7790: Add serial ports to the device tree
>   ARM: shmobile: r8a7791: Add serial ports to the device tree
>   ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
>   ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT
> 
>  arch/arm/boot/dts/r8a7790-lager.dts              |  24 ++-
>  arch/arm/boot/dts/r8a7790.dtsi                   | 100 +++++++++++++
>  arch/arm/boot/dts/r8a7791-koelsch.dts            |  24 ++-
>  arch/arm/boot/dts/r8a7791.dtsi                   | 180 +++++++++++++++++++++++
>  arch/arm/mach-shmobile/board-koelsch-reference.c |  18 +--
>  arch/arm/mach-shmobile/board-lager-reference.c   |  18 +--
>  arch/arm/mach-shmobile/clock-r8a7790.c           |  16 +-
>  arch/arm/mach-shmobile/clock-r8a7791.c           |  24 +--
>  arch/arm/mach-shmobile/setup-r8a7790.c           |  26 ++--
>  arch/arm/mach-shmobile/setup-r8a7791.c           |  34 ++---
>  10 files changed, 374 insertions(+), 90 deletions(-)
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

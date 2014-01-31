From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Jan 2014 09:44:35 +0900
Subject: [PATCH 00/03] ARM: shmobile: Lager USBHS update
In-Reply-To: <20140129230959.22655.55645.sendpatchset@w520>
References: <20140129230959.22655.55645.sendpatchset@w520>
Message-ID: <20140131004432.GK14663@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 08:09:59AM +0900, Magnus Damm wrote:
> ARM: shmobile: Lager USBHS update
> 
> [PATCH 01/03] ARM: shmobile: Remove Lager USBHS UDC ifdefs

Thanks, I will queue this one up.

> [PATCH 02/03] pinctrl: sh-pfc: r8a7790: Break out USB0 OVC/VBUS

I believe that this one is for Laurent.

> [PATCH 03/03] ARM: shmobile: Lager USB0 cable detection workaround

I will hold off on this one as it depends on the previous patch.

> Update the Lager USB0 code to let the USBHS device always be present
> and check for DIP switch configuration. To be able to check the DIP
> switch configuration the r8a7790 PINCTRL bits need to be updated too.
> 
> With this series USB0 on Lager will be fixed to USB Function via the
> USBHS driver. In theory the SoC can also use USB Host on this port
> either via USBHS or PCI USB, but since cable detection is missing
> it is possible for the user to misconfigure USB Host and drive VBUS
> with the wrong cable. Because of that USB0 will be forced to stick
> to Function-only in the Lager board code.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git tag renesas-devel-v3.13-20140127
> 
>  arch/arm/mach-shmobile/board-lager.c |   29 ++++++++++++++++++++++-------
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |    9 +++++++++
>  2 files changed, 31 insertions(+), 7 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

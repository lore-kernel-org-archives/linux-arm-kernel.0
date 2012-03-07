From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Mar 2012 18:39:07 +0100
Subject: [PATCH 0/6] AT91 more DT bindings
In-Reply-To: <20120302192844.GB21255@game.jcrosoft.org>
References: <20120302192844.GB21255@game.jcrosoft.org>
Message-ID: <20120307173907.GE17087@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	Rob is ok for you?

Best Regards,
J.
On 20:28 Fri 02 Mar     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> HI,
> 
> 	The following patch series add the bindings for:
> 	 - PMC
> 	 - SDRAM/DDR Controller
> 	 - Reset Controller
> 	 - Shutdown Controller
> 
> The following changes since commit c5ec01650adb1976f928177cd7e71afcb82026c5:
> 
>   ARM: at91: dt: enable usb ehci for sam9g45 and sam9x5 (2012-03-02 00:46:37 +0800)
> 
> are available in the git repository at:
>   git://github.com/at91linux/linux-at91.git ..BRANCH.NOT.VERIFIED..
> 
> Jean-Christophe PLAGNIOL-VILLARD (6):
>       ARM: at91/dt: add specific DT soc init
>       ARM: at91: add pmc DT support
>       ARM: at91: always enable sam9 restart
>       ARM: at91: add RSTC (Reset Controller) dt support
>       ARM: at91: add ram controller DT support
>       ARM: at91: add Shutdown Controller (SHDWC) DT support
> 
>  .../devicetree/bindings/arm/atmel-at91.txt         |   60 ++++++++
>  .../devicetree/bindings/arm/atmel-pmc.txt          |   11 ++
>  arch/arm/boot/dts/at91sam9g20.dtsi                 |   20 +++
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |   21 +++
>  arch/arm/boot/dts/at91sam9m10g45ek.dts             |   11 ++
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |   20 +++
>  arch/arm/boot/dts/at91sam9x5cm.dtsi                |   11 ++
>  arch/arm/boot/dts/usb_a9g20.dts                    |   11 ++
>  arch/arm/mach-at91/Kconfig                         |   10 +-
>  arch/arm/mach-at91/at91sam9x5.c                    |    7 -
>  arch/arm/mach-at91/board-dt.c                      |    8 +-
>  arch/arm/mach-at91/clock.c                         |   54 ++++++-
>  arch/arm/mach-at91/generic.h                       |    2 +
>  arch/arm/mach-at91/include/mach/at91_shdwc.h       |    4 +-
>  arch/arm/mach-at91/include/mach/at91sam9x5.h       |    5 -
>  arch/arm/mach-at91/setup.c                         |  158 ++++++++++++++++++++
>  16 files changed, 380 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt
> 
> Best Regards,
> J.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

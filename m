From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 9 Dec 2013 12:42:33 +0100
Subject: [PATCH 00/11] ARM: at91: DT: switch C board to DT
In-Reply-To: <20131115143855.GR28304@ns203013.ovh.net>
References: <20131115143855.GR28304@ns203013.ovh.net>
Message-ID: <52A5ACA9.90203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/2013 15:38, Jean-Christophe PLAGNIOL-VILLARD :
> Hi,
>
> 	As we have now enough DT support we can start to drop C board support
> 	for some boards
>
> 	Here is the first batch of boards (10) droping.
>
> The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:
>
>    Linux 3.12 (2013-11-03 15:41:51 -0800)
>
> are available in the git repository at:
>
>    git://github.com/at91linux/linux-at91.git j/for-3.14-dt-switch
>
> for you to fetch changes up to 10dd7da058bcb77db271d0ed023fe5dc5be0f75d:
>
>    ARM: at91: switch Calao QIL-A9260 board to DT (2013-11-15 05:06:39 +0800)
>
> ----------------------------------------------------------------
> Jean-Christophe PLAGNIOL-VILLARD (11):
>        ARM: at91: dt: at91rm9200ek: add emac and nor flash support
>        ARM: at91: switch 1arm to DT
>        ARM: at91: switch carmeva to DT
>        ARM: at91: switch kafa board to DT
>        ARM: at91: switch flexibity to DT
>        ARM: at91: switch RSI EWS board to DT
>        ARM: at91: switch Picotux 200 board to DT
>        ARM: at91: switch ecbat91 board to DT
>        ARM: at91: switch kb9202 board to DT
>        ARM: at91: switch csb637 board to DT
>        ARM: at91: switch Calao QIL-A9260 board to DT

Hi,

I didn't have any feedback from any of the board maintainers. Maybe it 
is because they were not in copy of this email.

So I try to collect email addresses and send a heads up with this email...

Jean-Christophe, as I know that you are maintainer for Calao, I take 
this patch only for the moment (and the EK related patch).

Best regards,

>   arch/arm/boot/dts/Makefile                  |  10 +++++++
>   arch/arm/boot/dts/at91-1arm.dts             |  70 ++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-carmeva.dts          | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-csb637.dts           |  83 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-ecbat91.dts          | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-flexibity.dts        | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-kafa.dts             |  79 +++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-kb9202.dts           | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-picotux-200.dts      |  93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-qil_a9260.dts        | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91-rsi-ews.dts          | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/at91rm9200ek.dts          |  34 +++++++++++++++++++++
>   arch/arm/configs/at91rm9200_defconfig       |   7 -----
>   arch/arm/configs/at91sam9260_9g20_defconfig |   2 --
>   arch/arm/mach-at91/Kconfig.non_dt           |  60 -------------------------------------
>   arch/arm/mach-at91/Makefile                 |  10 -------
>   arch/arm/mach-at91/board-1arm.c             |  99 --------------------------------------------------------------
>   arch/arm/mach-at91/board-carmeva.c          | 166 -------------------------------------------------------------------------------------------------------
>   arch/arm/mach-at91/board-csb637.c           | 141 ---------------------------------------------------------------------------------------
>   arch/arm/mach-at91/board-ecbat91.c          | 190 ----------------------------------------------------------------------------------------------------------------------
>   arch/arm/mach-at91/board-flexibity.c        | 168 --------------------------------------------------------------------------------------------------------
>   arch/arm/mach-at91/board-kafa.c             | 112 ----------------------------------------------------------------------
>   arch/arm/mach-at91/board-kb9202.c           | 158 --------------------------------------------------------------------------------------------------
>   arch/arm/mach-at91/board-picotux200.c       | 128 -------------------------------------------------------------------------------
>   arch/arm/mach-at91/board-qil-a9260.c        | 266 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
>   arch/arm/mach-at91/board-rsi-ews.c          | 231 -----------------------------------------------------------------------------------------------------------------------------------------------
>   26 files changed, 1293 insertions(+), 1738 deletions(-)
>   create mode 100644 arch/arm/boot/dts/at91-1arm.dts
>   create mode 100644 arch/arm/boot/dts/at91-carmeva.dts
>   create mode 100644 arch/arm/boot/dts/at91-csb637.dts
>   create mode 100644 arch/arm/boot/dts/at91-ecbat91.dts
>   create mode 100644 arch/arm/boot/dts/at91-flexibity.dts
>   create mode 100644 arch/arm/boot/dts/at91-kafa.dts
>   create mode 100644 arch/arm/boot/dts/at91-kb9202.dts
>   create mode 100644 arch/arm/boot/dts/at91-picotux-200.dts
>   create mode 100644 arch/arm/boot/dts/at91-qil_a9260.dts
>   create mode 100644 arch/arm/boot/dts/at91-rsi-ews.dts
>   delete mode 100644 arch/arm/mach-at91/board-1arm.c
>   delete mode 100644 arch/arm/mach-at91/board-carmeva.c
>   delete mode 100644 arch/arm/mach-at91/board-csb637.c
>   delete mode 100644 arch/arm/mach-at91/board-ecbat91.c
>   delete mode 100644 arch/arm/mach-at91/board-flexibity.c
>   delete mode 100644 arch/arm/mach-at91/board-kafa.c
>   delete mode 100644 arch/arm/mach-at91/board-kb9202.c
>   delete mode 100644 arch/arm/mach-at91/board-picotux200.c
>   delete mode 100644 arch/arm/mach-at91/board-qil-a9260.c
>   delete mode 100644 arch/arm/mach-at91/board-rsi-ews.c
>
> Best Regards,
> J.
>
>


-- 
Nicolas Ferre

From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 24 Oct 2015 13:38:48 -0700
Subject: [GIT PULL 1/2] Broadcom Device Tree changes for 4.4 (Part 2, try2)
In-Reply-To: <1445718981-13552-2-git-send-email-f.fainelli@gmail.com>
References: <1445718981-13552-1-git-send-email-f.fainelli@gmail.com>
 <1445718981-13552-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <562BEC58.8090309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 24/10/2015 13:36, Florian Fainelli a ?crit :
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Broadcom/stblinux tags/arm/soc/for-4.4/rpi-dt-v2
> 
> for you to fetch changes up to 121432c7a02f3818eefcad88c9ec428b7139b84a:
> 
>   ARM: bcm2835: Add the DDC I2C controller to the device tree. (2015-10-23 10:04:02 +0100)

Apologies since received this email 3 times and doing a typo on lakml,
looks like this is one of these days.

Let me know if this pull request looks in a better shape than the
previous one, thanks!

> 
> ----------------------------------------------------------------
> This pull request contains the DT changes for BCM2835 in 4.4.  It
> pulls in clk/clk-bcm2835 (which Stephen Boyd has said would be stable)
> because the DT changes to enable the clock driver need the driver
> itself to be present. These changes include the following:
> 
> - Eric Anholt, moves the bcm2835 clock driver under bcm/ where it belongs with
>   other Broadcom clock providers drivers, defines the binding for new clock
>   driver, adds support for programming the BCM2835 audio domain, adds the DDC I2C
>   controller to Device Tree, and finally migrates the Device Tree to use the new
>   clock driver binding
> 
> - Lubomir Rintel adds support for the Raspberry Pi Model A+ and B revision 2, and
>   remove the I2S controller which is non-existent on Raspberry Pi Model B
> 
> - Stefan Wahren adds an uart0 label for referencing the UART adapter
> 
> ----------------------------------------------------------------
> Eric Anholt (6):
>       clk: bcm2835: Move under bcm/ with other Broadcom SoC clk drivers.
>       clk: bcm2835: Add binding docs for the new platform clock driver.
>       clk: bcm2835: Add support for programming the audio domain clocks
>       Merge remote-tracking branch 'clk/clk-bcm2835' into bcm2835-dt-next
>       ARM: bcm2835: Switch to using the new clock driver support.
>       ARM: bcm2835: Add the DDC I2C controller to the device tree.
> 
> Lubomir Rintel (3):
>       ARM: bcm2835: dt: Raspberry Pi Model B had no I2S
>       ARM: bcm2835: dt: Add Raspberry Pi Model B rev2
>       ARM: bcm2835: dt: Add Raspberry Pi Model A+
> 
> Stefan Wahren (1):
>       ARM: bcm2835: add label for uart0
> 
>  .../bindings/clock/brcm,bcm2835-cprman.txt         |   45 +
>  arch/arm/boot/dts/Makefile                         |    4 +-
>  arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   30 +
>  arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   23 +
>  arch/arm/boot/dts/bcm2835-rpi-b.dts                |    8 +-
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |    4 +
>  arch/arm/boot/dts/bcm2835.dtsi                     |   64 +-
>  drivers/clk/Makefile                               |    1 -
>  drivers/clk/bcm/Makefile                           |    1 +
>  drivers/clk/bcm/clk-bcm2835.c                      | 1575 ++++++++++++++++++++
>  drivers/clk/clk-bcm2835.c                          |   55 -
>  include/dt-bindings/clock/bcm2835.h                |   47 +
>  12 files changed, 1768 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
>  create mode 100644 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
>  create mode 100644 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
>  create mode 100644 drivers/clk/bcm/clk-bcm2835.c
>  delete mode 100644 drivers/clk/clk-bcm2835.c
>  create mode 100644 include/dt-bindings/clock/bcm2835.h
> 


-- 
Florian

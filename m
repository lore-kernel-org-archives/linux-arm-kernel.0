From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 9 Jul 2018 10:49:48 -0700
Subject: [GIT PULL 5/6] Broadcom drivers changes for 4.19
In-Reply-To: <20180709153035.6376-5-f.fainelli@gmail.com>
References: <20180709153035.6376-1-f.fainelli@gmail.com>
 <20180709153035.6376-5-f.fainelli@gmail.com>
Message-ID: <c3cc71d0-a2eb-da1d-1016-bde249936aaa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof Kevin,

On 07/09/2018 08:30 AM, Florian Fainelli wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/drivers
> 
> for you to fetch changes up to 25ee284c21a8d950af463d4235995eeecc5fc70b:
> 
>   Merge tag 'bcm2835-drivers-next-2018-07-03' into drivers/next (2018-07-09 05:22:16 -0700)

I will be re-doing this one to squash this patch in:

https://patchwork.kernel.org/patch/10514987/

> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM/ARM64/MIPS SoCs drivers changes
> for 4.19, please pull the following:
> 
> - Doug updates the low-level suspend/resume code for ARM SoCs to support
>   the latest rev B3.0 memory controllers found on newer chips with an
>   appropriate match structure to perform the correct entry sequencing
> 
> - Florian updates the Device Tree binding document for these memory
>   controllers to list all possible compatible strings that exist given
>    the supported memory controllers.
> 
> - Stefan adds the GET_THROTTLED firmware property value that is required
>   for the Rasperry Pi voltage monitoring driver and updates the
>   Raspberry Pi firmware driver accordingly to register such a device using
>   the HWMON subsystem. Finally he adds support for reporting under
>   voltage conditions using a specialized HWMON driver.
> 
> ----------------------------------------------------------------
> Doug Berger (1):
>       soc: bcm: brcmstb: pm: Add support for newer rev B3.0 controllers
> 
> Florian Fainelli (2):
>       soc: bcm: brcmstb: Add missing DDR MEMC compatible strings
>       Merge tag 'bcm2835-drivers-next-2018-07-03' into drivers/next
> 
> Kees Cook (1):
>       firmware: raspberrypi: Remove VLA usage
> 
> Stefan Wahren (3):
>       ARM: bcm2835: Add GET_THROTTLED firmware property
>       hwmon: Add support for RPi voltage sensor
>       firmware: raspberrypi: Register hwmon driver
> 
>  .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   4 +
>  Documentation/hwmon/raspberrypi-hwmon              |  22 +++
>  drivers/firmware/raspberrypi.c                     |  29 +++-
>  drivers/hwmon/Kconfig                              |  10 ++
>  drivers/hwmon/Makefile                             |   1 +
>  drivers/hwmon/raspberrypi-hwmon.c                  | 166 +++++++++++++++++++++
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c                |  16 ++
>  include/soc/bcm2835/raspberrypi-firmware.h         |   1 +
>  8 files changed, 247 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/hwmon/raspberrypi-hwmon
>  create mode 100644 drivers/hwmon/raspberrypi-hwmon.c
> 

-- 
Florian

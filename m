From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 04 Feb 2015 10:04:33 +0100
Subject: [PATCH v4 0/5] Add a new RTC driver for recent mvebu SoCs
In-Reply-To: <1421342601-20384-1-git-send-email-gregory.clement@free-electrons.com>
References: <1421342601-20384-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <54D1E0A1.4000702@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 15/01/2015 18:23, Gregory CLEMENT wrote:
> Hi,
> 
> The Marvell Armada 38x SoCs contains an RTC which differs from the RTC
> used in the other mvebu SoCs until now. This forth version of the
> patch set adds support for this new IP and enable it in the Device
> Tree of the Armada 38x SoC.

This last version of this series have been sent 3 weeks ago. Is there
an hope to be merged in 3.20 ?

Should they go through via Andrew Morten's tree ?


Thanks,

Gregory


> 
> Thanks,
> 
> Gr?gory
> 
> Changelog
> 
> v3 -> v4:
> 
> - Formatted the device tree binding documentation in a better way
> - Renamed the soc-int regmap to rtc-soc because this group of register
>   was not only about the interrupt.
> - Fixed the rtc_delayed_write function. I found the exact description
>   of the WA to use, and the wait should really be after the write.
> 
> v2 -> v3:
> 
> - Fixed the reg-names description in the dt binding documentation
> - Used the delayed version of the writel in everyplace.
> 
> v1 -> v2:
> 
> - Used reg-names to identify the registers in the device tree
> - Changed the space into tab in the MAINTAINERS file
> - Emphasized that the 5s wait was only needed between two consecutive
>   writes
> - Reduced the wait in the set_time function, 100ms were enough
> - If no interrupt was available, then disable the alarm related
>   functions
> - Fixed the critical sections
> - Updated the mvebu_v7_defconfig by enabling the new RTC support
> 
> 
> Gregory CLEMENT (5):
>   rtc: armada38x: Add the device tree binding documentation
>   drivers/rtc/rtc-armada38x: Add a new RTC driver for recent mvebu SoCs
>   MAINTAINERS: Add the RTC driver for the Armada38x
>   ARM: mvebu: add Device Tree description of RTC on Armada 38x
>   ARM: mvebu: enable Armada 38x RTC driver in mvebu_v7_defconfig
> 
>  .../devicetree/bindings/rtc/armada-380-rtc.txt     |  22 ++
>  MAINTAINERS                                        |   1 +
>  arch/arm/boot/dts/armada-38x.dtsi                  |   7 +
>  arch/arm/configs/mvebu_v7_defconfig                |   1 +
>  drivers/rtc/Kconfig                                |  10 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-armada38x.c                        | 320 +++++++++++++++++++++
>  7 files changed, 362 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
>  create mode 100644 drivers/rtc/rtc-armada38x.c
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

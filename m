From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Sun, 26 Jun 2016 18:39:05 +0200
Subject: [RFC v4 0/7] extcon: usb-gpio: fixes and improvements
In-Reply-To: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <57700529.7090707@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

just wanted to ask on which kernel branch the patchset is based on. At
least for me the set doesn't apply cleanly to 4.7-rc4.

With best wishes,
Tobias


Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Some time ago, Robert tried to add VBUS detection to extcon-usb-gpio
> driver [1].  There was a discussion about patch #2 ("extcon: usb-gpio:
> add support for VBUS detection").
> 
> The final conclusion was that Chanwoo will add VBUS/ID notifiers [2].
> That unfortunately never happened so this patchset is a follow up.
> 
> 1. Add VBUS/ID cable state notifiers to extcon, so USB controllers
>    could use it.
> 2. Add VBUS detection to extcon-usb-gpio driver.
> 
> Some parts are based on old Robert's work, some are new, some are
> reworked.
> 
> 
> Best regards,
> Krzysztof
> 
> 
> [1] http://thread.gmane.org/gmane.linux.kernel/1923192/focus=1923193
> [2] http://thread.gmane.org/gmane.linux.kernel/1923192/focus=1941152
> 
> 
> Krzysztof Kozlowski (5):
>   Revert "extcon: usb-gpio: switch to use pm wakeirq apis"
>   extcon: Add raw VBUS and ID cable states
>   extcon: usb-gpio: Add support for VBUS detection
>   ARM: exynos_defconfig: Enable EXTCON_USB_GPIO for Odroid XU3 USB OTG
>   ARM: dts: exynos: Add extcon-usb-gpio node for Odroid XU3
> 
> Robert Baldyga (2):
>   Documentation: extcon: usb-gpio: update usb-gpio binding description
>   extcon: usb-gpio: make debounce value configurable in devicetree
> 
>  .../devicetree/bindings/extcon/extcon-usb-gpio.txt |  28 ++++-
>  arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |  21 ++++
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  21 ++++
>  arch/arm/configs/exynos_defconfig                  |   1 +
>  drivers/extcon/extcon-usb-gpio.c                   | 138 +++++++++++++++++----
>  drivers/extcon/extcon.c                            |   3 +
>  include/linux/extcon.h                             |   8 +-
>  7 files changed, 190 insertions(+), 30 deletions(-)
> 

From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 7 Feb 2014 10:42:38 +0000
Subject: [PATCH v2 14/15] charger: max14577: Configure battery-dependent
 settings from DTS
In-Reply-To: <1391767487-10017-15-git-send-email-k.kozlowski@samsung.com>
References: <1391767487-10017-1-git-send-email-k.kozlowski@samsung.com>
 <1391767487-10017-15-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140207104238.GH14727@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Remove hard-coded values for:
>  - Fast Charge current,
>  - End Of Charge current,
>  - Fast Charge timer,
>  - Overvoltage Protection Threshold,
>  - Battery Constant Voltage,
> and use DTS to configure them. This allows using the max14577 charger
> driver with different batteries.
> 
> Now the charger driver requires valid configuration data from DTS. In
> case of wrong configuration data it fails during probe. Patch adds
> of_compatible to the charger mfd cell in MFD driver core.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I already acked the MFD parts of this. Or has the patch changed?

> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Jenny Tc <jenny.tc@intel.com>
> ---
>  drivers/mfd/max14577.c               |    5 +-
>  drivers/power/max14577_charger.c     |  234 +++++++++++++++++++++++++++++-----
>  include/linux/mfd/max14577-private.h |   10 ++
>  include/linux/mfd/max14577.h         |    8 ++
>  4 files changed, 227 insertions(+), 30 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

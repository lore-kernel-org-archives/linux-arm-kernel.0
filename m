From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Feb 2014 10:24:31 +0000
Subject: [PATCH 15/18] regulator: max14577: Add support for max77836
 regulators
In-Reply-To: <1390911522-28209-16-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-16-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140203102431.GN13529@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jan 2014, Krzysztof Kozlowski wrote:

> Add support for MAX77836 chipset and its additional two LDO regulators.
> These LDO regulators are controlled by the PMIC block with additional
> regmap (different I2C slave address).
> 
> The MAX77836 charger and safeout regulators are almost identical to
> MAX14577. The registry layout is the same, except values for charger's
> current. The patch adds simple mapping between device type and supported
> current by the charger regulator.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/regulator/max14577.c         |  275 +++++++++++++++++++++++++++++-----
>  include/linux/mfd/max14577-private.h |   32 +++-
>  include/linux/mfd/max14577.h         |   10 ++
>  3 files changed, 281 insertions(+), 36 deletions(-)

For the MFD changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

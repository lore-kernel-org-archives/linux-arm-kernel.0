From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Jun 2014 22:17:47 +0100
Subject: [PATCH v2 07/10] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140617211747.GY29841@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The MAX77802 PMIC has 10 high-efficiency Buck and 32 Low-dropout
> (LDO) regulators. This patch adds support for all these regulators
> found on the MAX77802 PMIC and is based on a driver added by Simon
> Glass to the Chrome OS kernel 3.8 tree.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Changes since v1:
>  - Remove unneeded check if num_regulators != MAX77802_MAX_REGULATORS.
>  - Fix .set_suspend_mode handler comment and split regulators ops for
>    regulators that behave differently. Suggested by Mark Brown.
>  - Use module_platform_driver() instead of having init/exit functions.
>    Suggested by Mark Brown.
>  - Use the new descriptor-based GPIO interface instead of the deprecated
>    integer based GPIO one. Suggested by Mark Brown.
>  - Look for "regulators" child node instead of "voltage-regulators" to be
>    consistent with other PMIC drivers. Suggested by Mark Brown.
> 
>  drivers/mfd/max77802.c       |   1 +

Can you remove all of the MFD changes from patches 7, 8 and 9 and
create new one.  That way there's no requirement for any cross
subsystem messiness.

>  drivers/regulator/Kconfig    |   9 +
>  drivers/regulator/Makefile   |   1 +
>  drivers/regulator/max77802.c | 701 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 712 insertions(+)
>  create mode 100644 drivers/regulator/max77802.c

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

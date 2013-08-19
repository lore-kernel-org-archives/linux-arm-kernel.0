From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 13:12:06 -0600
Subject: [PATCH] pinctrl: Pass all configs to driver on pin_config_set()
In-Reply-To: <1376606573-15093-1-git-send-email-syin@broadcom.com>
References: <1376606573-15093-1-git-send-email-syin@broadcom.com>
Message-ID: <52126E06.1040108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2013 04:42 PM, Sherman Yin wrote:
> When setting pin configuration in the pinctrl framework, pin_config_set() or
> pin_config_group_set() is called in a loop to set one configuration at a time
> for the specified pin or group.
> 
> This patch 1) removes the loop and 2) changes the API to pass the whole pin
> config array to the driver.  It is now up to the driver to loop through the
> configs.  This allows the driver to potentially combine configs and reduce the
> number of writes to pin config registers.
> 
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>

> Change-Id: I99cbfa2ae7b774456eb71edb276711b1ddcd42c8

That tag shouldn't be included in upstream patches.

>  drivers/pinctrl/pinconf.c             |   42 ++++----
>  drivers/pinctrl/pinctrl-tegra.c       |   69 ++++++------
>  include/linux/pinctrl/pinconf.h       |    6 +-

Those files, Reviewed-by: Stephen Warren <swarren@nvidia.com>

On Tegra (Tegra114 Dalmore board, on top of next-20130816),
Tested-by: Stephen Warren <nvidia.com>

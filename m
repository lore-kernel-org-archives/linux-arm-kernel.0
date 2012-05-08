From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 8 May 2012 13:16:32 -0700
Subject: [PATCH v3 3/6] hwmon: exynos4: Move thermal sensor driver to
 driver/thermal directory
In-Reply-To: <1336493898-7039-4-git-send-email-amit.kachhap@linaro.org>
References: <1336493898-7039-1-git-send-email-amit.kachhap@linaro.org>
 <1336493898-7039-2-git-send-email-amit.kachhap@linaro.org>
 <1336493898-7039-3-git-send-email-amit.kachhap@linaro.org>
 <1336493898-7039-4-git-send-email-amit.kachhap@linaro.org>
Message-ID: <20120508131632.49d0ac99.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  8 May 2012 21:48:15 +0530
Amit Daniel Kachhap <amit.kachhap@linaro.org> wrote:

> This movement is needed because the hwmon entries and corresponding
> sysfs interface is a duplicate of utilities already provided by
> driver/thermal/thermal_sys.c. The goal is to place it in thermal folder
> and add necessary functions to use the in-kernel thermal interfaces.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> ---
>  Documentation/hwmon/exynos4_tmu              |   81 ----
>  Documentation/thermal/exynos_thermal         |   52 +++
>  drivers/hwmon/Kconfig                        |   10 -
>  drivers/hwmon/Makefile                       |    1 -
>  drivers/hwmon/exynos4_tmu.c                  |  514 --------------------------

Please cc the hwmon people?  Jean Delvare <khali@linux-fr.org>, Guenter
Roeck <guenter.roeck@ericsson.com>, lm-sensors at lm-sensors.org

>  drivers/thermal/Kconfig                      |    9 +
>  drivers/thermal/Makefile                     |    1 +
>  drivers/thermal/exynos_thermal.c             |  409 ++++++++++++++++++++
>  include/linux/platform_data/exynos4_tmu.h    |   83 ----
>  include/linux/platform_data/exynos_thermal.h |   83 ++++

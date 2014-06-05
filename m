From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 16:16:50 +0100
Subject: [STLinux Kernel] [PATCH 3/6] thermal: sti: Add support for ST's
 System Config Register based Thermal controller
In-Reply-To: <1401442715-6350-4-git-send-email-lee.jones@linaro.org>
References: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
 <1401442715-6350-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20140605151650.GB7446@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

See my comments below: -

> +/* STiH416 */
> +#define STIH416_SYSCFG_FRONT(num)		((num - 1000) * 4)
> +#define STIH416_SAS_THSENS_CONF			STIH416_SYSCFG_FRONT(1552)
> +#define STIH416_SAS_THSENS_STATUS1		STIH416_SYSCFG_FRONT(1554)
> +#define STIH416_SAS_THSENS_STATUS2		STIH416_SYSCFG_FRONT(1594)
> +
> +/* STiD127 */
> +#define STID127_SYSCFG_CPU(num)			((num - 700) * 4)
> +#define STID127_THSENS_CONF			STID127_SYSCFG_CPU(743)
> +#define STID127_THSENS_STATUS			STID127_SYSCFG_CPU(767)

There is no upstream support for STiD127 SoC AFAIK? I think this should be removed
from the driver and just keep stih415 / stih416 parts.

Also a seperate somewhat unrelated question... stih415 and stih416 are very similar 
dual die parts. Do you know why the stih415 has support for sas & mpe die temperature
sensors, but the stih416 only has support for the sas die?

Regards,

Peter

From: kiran.padwal@smartplayin.com (kiran.padwal at smartplayin.com)
Date: Thu, 17 Jul 2014 06:30:24 -0400 (EDT)
Subject: [Patch v7 2/3] usb: phy: Add Qualcomm DWC3 HS/SS PHY drivers
In-Reply-To: <CA+neC=McWS8=iSi2XShJyvc85Aw4PSmF-osNpVgJv42d9or1WQ@mail.gmail.com>
References: <1404144233-17222-1-git-send-email-agross@codeaurora.org>
 <1404144233-17222-3-git-send-email-agross@codeaurora.org>
 <CA+neC=McWS8=iSi2XShJyvc85Aw4PSmF-osNpVgJv42d9or1WQ@mail.gmail.com>
Message-ID: <1405593024.423213197@apps.rackspace.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 30, 2014 at 9:33 PM, Andy Gross <agross@codeaurora.org> wrote: 
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> These drivers handles control and configuration of the HS
> and SS USB PHY transceivers. They are part of the driver
.
[snip]
.
> +#include <linux/usb/phy.h>
> +
> +/**
> + *  USB QSCRATCH Hardware registers
> + */

unused define, can you please remove it

> +#define QSCRATCH_CTRL_REG              (0x04)
> +#define QSCRATCH_GENERAL_CFG           (0x08)
> +#define PHY_CTRL_REG                   (0x10)
> +#define PARAMETER_OVERRIDE_X_REG       (0x14)

ditto

> +#define CHARGING_DET_CTRL_REG          (0x18)

ditto

> +#define CHARGING_DET_OUTPUT_REG                (0x1c)

ditto

> +#define ALT_INTERRUPT_EN_REG           (0x20)

ditto

> +#define PHY_IRQ_STAT_REG               (0x24)

ditto

> +#define CGCTL_REG                      (0x28)
> +
> +#define PHY_3P3_VOL_MIN                        3050000 /* uV */
> +#define PHY_3P3_VOL_MAX                        3300000 /* uV */
> +#define PHY_3P3_HPM_LOAD               16000   /* uA */
> +
.
[snip]
.
> +MODULE_ALIAS("platform:qcom-dwc3-ssphy");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("DesignWare USB3 QCOM SSPHY driver");
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Regards,
Kiran Padwal

From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 22 May 2012 13:21:44 +0300
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
Message-ID: <87bolgbjnr.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> +#include "ci.h"
> +
> +#define PORT0_STATUS	0x184

This doesn't seem to be used anywhere.

[snip]
> +	ci13xxx_imx_udc_driver.phy = data->phy;

See my comment to the other patch about phy pointer being a per-device
thing rather then per-platform driver. Now, (at the risk of being
flamed) I think it could work if you allocated the
ci13xxx_imx_udc_driver dynamically in every probe, but that's not what
you want to do for the actual platform data. So, I suggest we come up
with a better way of passing phy to the driver. I also think that it's
really about time we renamed "struct ci13xxx_udc_driver" to something
that emphasizes the "platform" in it. What do you think?

Regards,
--
Alex

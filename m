From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 1 Oct 2012 14:03:43 +0200
Subject: [PATCHv3 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
In-Reply-To: <1349089282-22105-1-git-send-email-sourav.poddar@ti.com>
References: <1349089282-22105-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20121001120343.GG12231@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sourav,

On Mon, Oct 01, 2012 at 04:31:22PM +0530, Sourav Poddar wrote:
> smsc ece1099 is a keyboard scan or gpio expansion device.
> The patch create keypad and gpio expander child for this
> multi function smsc driver.
> 
> Tested on omap5430 evm with 3.6-rc6 custom kernel.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> Changes since v2:
>  - Change the cache type, max register assignment
>  - remove of_device_table, since i2c based device gets 
> probed according to i2c_device_id through dt.
>  - Modify the remove function
>  - Minor return patch cleanups.
>  Documentation/smsc_ece1099.txt |   56 ++++++++++++++++++++
>  drivers/mfd/Kconfig            |   12 ++++
>  drivers/mfd/Makefile           |    1 +
>  drivers/mfd/smsc-ece1099.c     |  113 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/smsc.h       |  109 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 291 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/smsc_ece1099.txt
>  create mode 100644 drivers/mfd/smsc-ece1099.c
>  create mode 100644 include/linux/mfd/smsc.h
Applied with a warning fix for the !CONFIG_OF case.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

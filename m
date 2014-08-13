From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 13 Aug 2014 12:50:01 +0200
Subject: [PATCH v3] watchdog: Add DA906x PMIC watchdog driver.
In-Reply-To: <1407926776-16700-1-git-send-email-mpa@pengutronix.de>
References: <1407926776-16700-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140813105001.GF17027@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 13, 2014 at 12:46:16PM +0200, Markus Pargmann wrote:
> From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> 
> This driver supports the watchdog device inside the DA906x PMIC.
> 
> Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/watchdog/Kconfig      |   7 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/da9063_wdt.c | 228 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 236 insertions(+)
>  create mode 100644 drivers/watchdog/da9063_wdt.c

Forgot to add --notes to send-email.

Here are the changes in v3:
     - Cleanup error handling for timeout selection and setting
     - Fix race condition due to late wdt drvdata setup
     - Remove static struct watchdog_device. It is not initialized in the probe
       function
     - Use WATCHDOG_NOWAYOUT_INIT_STATUS for the status
     - Remove 0 shift using DA9063_TWDSCALE_SHIFT

Best regards,

Markus Pargmann

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/f4c51265/attachment.sig>

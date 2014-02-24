From: pratyush.anand@st.com (Pratyush Anand)
Date: Mon, 24 Feb 2014 11:41:48 +0530
Subject: [PATCH 5/5] mmc: sdhci-spear: use generic card detection gpio
 support
In-Reply-To: <E1WGnXs-0007Jw-0M@rmk-PC.arm.linux.org.uk>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
 <E1WGnXs-0007Jw-0M@rmk-PC.arm.linux.org.uk>
Message-ID: <20140224061148.GB3905@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Feb 21, 2014 at 06:41:28PM +0800, Russell King wrote:
> sdhci has support for using GPIOs for card detection.  If we have a
> GPIO specified, we can use that directly, without needing our own
> interrupt handler.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci-spear.c | 78 +++++++++---------------------------------
>  1 file changed, 16 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 00a73b1a6444..af3338fb0762 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c

To get mmc_gpio_request_cd declaration 

#include <linux/mmc/slot-gpio.h>

is needed.

Regards
Pratyush

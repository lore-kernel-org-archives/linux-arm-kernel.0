From: cjb@laptop.org (Chris Ball)
Date: Wed, 11 Apr 2012 16:27:44 -0400
Subject: [PATCH v2] mmc: remove imxmmc driver
In-Reply-To: <1334175889-30118-1-git-send-email-s.hauer@pengutronix.de>
 (Sascha Hauer's message of "Wed, 11 Apr 2012 22:24:49 +0200")
References: <1334175889-30118-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <87d37erp33.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 11 2012, Sascha Hauer wrote:
> This driver is broken since 2.6.31 when the traditional i.MX1
> support was removed.
>
> In theory the i.MX1 mmc controller can be supported by the mxcmmc
> driver which basically is the same hardware. However, the i.MX1
> controller has severe bugs which made several workarounds necessary which
> resulted in a different driver structure. At that time it seemed easier
> to write a second driver to support hardware without bugs.
>
> As noone cared for the i.MX1 driver for a long time and it does
> not compile, remove it.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>
> v2: Also remove imxmmc.h
>
>  drivers/mmc/host/Kconfig  |   10 -
>  drivers/mmc/host/Makefile |    1 -
>  drivers/mmc/host/imxmmc.c | 1169 ---------------------------------------------
>  drivers/mmc/host/imxmmc.h |   64 ---
>  4 files changed, 1244 deletions(-)
>  delete mode 100644 drivers/mmc/host/imxmmc.c
>  delete mode 100644 drivers/mmc/host/imxmmc.h

Thanks!  Pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

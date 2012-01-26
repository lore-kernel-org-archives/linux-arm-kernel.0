From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 26 Jan 2012 17:52:59 +0200
Subject: [PATCH v7 2/2] video: backlight: support s6e8ax0 panel driver
 based on MIPI DSI
In-Reply-To: <4F17AA14.8030100@samsung.com>
References: <4F17AA14.8030100@samsung.com>
Message-ID: <1327593179.2843.5.camel@lappy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2012-01-19 at 14:28 +0900, Donghwa Lee wrote:
> This patch is amoled panel driver based MIPI DSI interface.
> S6E8AX0 means it may includes many other ldi controllers, for example,
> S6E8AA0, S6E8AB0, and so on.
> 
> This patch can be modified depending on each panel properites. For example,
> second parameter of panel condition register can be changed depending on
> ldi controller or amoled type.
> 
> Changes since v6:
> 	- change data type from const to static const
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/video/backlight/Kconfig   |    7 +
>  drivers/video/backlight/Makefile  |    1 +
>  drivers/video/backlight/s6e8ax0.c |  898 +++++++++++++++++++++++++++++++++++++
>  drivers/video/backlight/s6e8ax0.h |   21 +
>  4 files changed, 927 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/backlight/s6e8ax0.c
>  create mode 100644 drivers/video/backlight/s6e8ax0.h

Why is this in backlight directory? It's a panel driver, not a backlight
driver.

And the driver is s5p specific, wouldn't a directory like
drivers/video/s5p/, where both the s5p DSI driver from the previous
patch and this panel driver could be?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120126/73d361ca/attachment.sig>

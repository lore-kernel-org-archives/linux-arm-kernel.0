From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 20 Aug 2015 13:55:46 +0300
Subject: [PATCH v1, TRIVIAL] Fix pxafb nonstd field documentation and
 add errata info
In-Reply-To: <55C64864.6070405@tul.cz>
References: <55C64864.6070405@tul.cz>
Message-ID: <55D5B232.9090006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/08/15 21:20, Petr Cvek wrote:

> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 2d98de5..8f485ec 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1893,6 +1893,11 @@ config FB_PXA_OVERLAY
>  	bool "Support PXA27x/PXA3xx Overlay(s) as framebuffer"
>  	default n
>  	depends on FB_PXA && (PXA27x || PXA3xx)
> +	---help---
> +	  Using the overlay 2 and YUV420 mode on a PXA27x C0 chip revision will
> +	  hang the LCD until the next SoC restart (errata E24).

Shouldn't the driver handle this? It should not allow the combination to
be used.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/042b80a1/attachment.sig>

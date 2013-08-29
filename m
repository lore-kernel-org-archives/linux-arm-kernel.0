From: joelf@ti.com (Joel Fernandes)
Date: Thu, 29 Aug 2013 18:31:12 -0500
Subject: [PATCH 1/3] crypto: omap-des: Add omap-des driver for OMAP4/AM43xx
In-Reply-To: <1377818873-21174-2-git-send-email-joelf@ti.com>
References: <1377818873-21174-1-git-send-email-joelf@ti.com>
 <1377818873-21174-2-git-send-email-joelf@ti.com>
Message-ID: <521FD9C0.6020302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2013 06:27 PM, Joel Fernandes wrote:
> Add omap-des driver with platform data for OMAP4. Support added for DES
> ECB and CBC modes.
> 
> Where possible, code is reused from omap-aes driver with changes made for
> adjusting key size, block size, removing non-existent encryption modes
> and adding support for OMAP4 platform data and offsets.
> 
> Tests have been conducted with the CRYPTO test manager, and functionality
> is verified at different page length alignments.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  drivers/crypto/omap-des.c | 1192 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1192 insertions(+)
>  create mode 100644 drivers/crypto/omap-des.c
> 
> diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
> new file mode 100644
> index 0000000..6a9a25f
> --- /dev/null
> +++ b/drivers/crypto/omap-des.c
> @@ -0,0 +1,1192 @@
> +/*
> + * Cryptographic API.
> + *
> + * Support for OMAP DES and Triple DES HW acceleration.
> + *
> + * Copyright (c) 2012 Texas Instruments Incorporated
> + * Author: Joel Fernandes <joelf@ti.com>

Have to change this to 2013. Will do so if there are no other comments.

Regards,

-Joel

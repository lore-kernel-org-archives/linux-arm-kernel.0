From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 12 Mar 2014 20:18:51 +0100
Subject: [PATCH 1/2 v4] i2c: exynos5: add support for HSI2C on Exynos5260
 SoC
In-Reply-To: <1391748171-12451-1-git-send-email-ch.naveen@samsung.com>
References: <1385100726-32165-1-git-send-email-ch.naveen@samsung.com>
 <1391748171-12451-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140312191851.GB28891@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:12:51AM +0530, Naveen Krishna Chatradhi wrote:
> This patch adds a new compatible and uses variant struct to support
> HSI2C module on Exynos5260. Updates the Documentation dt bindings.
> Also resets the module as an init sequence (Needed by Exynos5260).
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

This patch has clearly not been tested :( Build failure!

> +struct exynos_hsi2c_variant {
> +	unsigned int		    fifo_depth;
> +};

Why so many tabs? In general, I'd prefer one space.

> -	exynos5_i2c_init(i2c);
> +	exynos5_i2c_reset(i2c);

Is this a related change?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/ffc804ff/attachment.sig>

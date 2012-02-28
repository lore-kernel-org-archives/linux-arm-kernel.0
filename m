From: timur@freescale.com (Timur Tabi)
Date: Tue, 28 Feb 2012 10:51:09 -0600
Subject: [PATCH 4/6] ASoC: fsl: create fsl_utils to accommodate the common
 functions
In-Reply-To: <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F4D05FD.5000401@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> +EXPORT_SYMBOL_GPL(fsl_asoc_get_codec_dev_name);

Please use EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL().  Freescale does
not want to impose license restrictions on its customers.

Also, I think there's a bug in this function that I never got around to
fixing.  I think you need to call put_device() somewhere.
of_find_i2c_device_by_node() calls bus_find_device(), which calls
get_device(), which increments the reference count.

-- 
Timur Tabi
Linux kernel developer at Freescale

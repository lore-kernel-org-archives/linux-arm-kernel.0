From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Apr 2010 16:05:26 +0100
Subject: [alsa-devel] [PATCH] WM8750: Convert to new API
In-Reply-To: <1270738749-5048-1-git-send-email-marek.vasut@gmail.com>
References: <1270738749-5048-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100408150526.GA6792@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 08, 2010 at 04:59:09PM +0200, Marek Vasut wrote:

> @@ -172,6 +198,10 @@ static int __init jive_init(void)
>  	if (!machine_is_jive())
>  		return 0;
>  
> +	ret = wm8750_i2c_setup();
> +	if (ret != 0)
> +		return ret;
> +

Quoting from my mail of 15:58 (5 minutes ago!):

| The WM8750 on the JIVE is connected using SPI, not I2C.  You'll want to
| CC in the JIVE and S3C maintainer too (Ben Dooks for both).  Looking at
| the Jive machine file it's actually registering the SPI device in
| arch/arm already so there shouldn't be any need to add any registration
| code at all.

To repeat, the WM8750 on JIVE is connected using SPI, not I2C.  This
means you should not be registering an I2C device.

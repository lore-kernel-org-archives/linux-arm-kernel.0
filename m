From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 16 Jul 2014 19:46:05 +0200
Subject: [PATCH 00/16] i2c: drop class based instantiaion for selected
 drivers
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20140716174604.GI2759@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 01:46:20PM +0200, Wolfram Sang wrote:
> Some drivers were flagged to remove class based instantiation soon to improve
> boot-up time. Originally, I was planning for a longer deprecation time so users
> could switch over to some other kind of instantiation. However, the demand for
> the speed up is high enough and class based instantiation is used rarely, so
> the removal takes place now. To make up for the deprecation time, another
> warning is added to the i2c core pointing out that the behaviour has now
> changed:
> 
> +	/* Warn that the adapter lost class based instantiation */
> +	if (adapter->class == I2C_CLASS_DEPRECATED) {
> +		dev_dbg(&adapter->dev,
> +			"This adapter dropped support for I2C classes and "
> +			"won't auto-detect %s devices anymore. If you need it, check "
> +			"'Documentation/i2c/instantiating-devices' for alternatives.\n",
> +			driver->driver.name);
> +		return 0;
> +	}
> 
> A branch can be found here (with two other cleanups -> driver removals):
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/deprecate_stuff
> 
> I hope this meets all the needs. Please comment, ack, test...
> 
> Thanks,
> 
>    Wolfram
> 
> 
> Wolfram Sang (16):
>   i2c: add debug info when class instantiation was dropped
>   i2c: i2c-at91: Drop class based scanning to improve bootup time
>   i2c: i2c-bcm2835: Drop class based scanning to improve bootup time
>   i2c: i2c-bfin-twi: Drop class based scanning to improve bootup time
>   i2c: i2c-davinci: Drop class based scanning to improve bootup time
>   i2c: i2c-designware-platdrv: Drop class based scanning to improve
>     bootup time
>   i2c: i2c-mv64xxx: Drop class based scanning to improve bootup time
>   i2c: i2c-nomadik: Drop class based scanning to improve bootup time
>   i2c: i2c-ocores: Drop class based scanning to improve bootup time
>   i2c: i2c-omap: Drop class based scanning to improve bootup time
>   i2c: i2c-rcar: Drop class based scanning to improve bootup time
>   i2c: i2c-s3c2410: Drop class based scanning to improve bootup time
>   i2c: i2c-sirf: Drop class based scanning to improve bootup time
>   i2c: i2c-stu300: Drop class based scanning to improve bootup time
>   i2c: i2c-tegra: Drop class based scanning to improve bootup time
>   i2c: i2c-xiic: Drop class based scanning to improve bootup time
> 
>  drivers/i2c/busses/i2c-at91.c               |  2 +-
>  drivers/i2c/busses/i2c-bcm2835.c            |  2 +-
>  drivers/i2c/busses/i2c-bfin-twi.c           |  2 +-
>  drivers/i2c/busses/i2c-davinci.c            |  2 +-
>  drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
>  drivers/i2c/busses/i2c-mv64xxx.c            |  2 +-

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/49f27188/attachment.sig>

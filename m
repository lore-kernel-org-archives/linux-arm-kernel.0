From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 15 Feb 2014 16:03:45 +0100
Subject: [PATCH V2 11/17] i2c: nomadik: Convert to devm functions
In-Reply-To: <1392300547-23365-1-git-send-email-ulf.hansson@linaro.org>
References: <1392300547-23365-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140215150345.GD2579@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 03:09:02PM +0100, Ulf Hansson wrote:
> Use devm_* functions to simplify code and error handling.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	Rebased on top of latest i2c-nomadik branch.

Since this depends on Linus' patch already, I think it would be cleaner
if I pick this kinda unrelated (but wanted) devm patch, and ack the
PM stuff. If this for some reason makes things more complicated, I can
also simply ack this one.

> -	dev->virtbase = ioremap(adev->res.start, resource_size(&adev->res));
> +	dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
> +				resource_size(&adev->res));
>  	if (!dev->virtbase) {
>  		ret = -ENOMEM;

IS_ERR()!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140215/ba91bab3/attachment.sig>

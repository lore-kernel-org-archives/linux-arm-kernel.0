From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 25 Sep 2013 10:17:38 +0200
Subject: [PATCH usb 1/2] usb: musb: Add missing ATOMIC_INIT_NOTIFIER_HEAD
In-Reply-To: <201309181903.33243@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <20130918164816.GN21559@radagast> <201309181903.33243@pali>
Message-ID: <201309251017.39014@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 September 2013 19:03:33 Pali Roh?r wrote:
> &twl->phy.notifier is not initalized
> 
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> 
> diff --git a/drivers/usb/phy/phy-twl4030-usb.c
> b/drivers/usb/phy/phy-twl4030-usb.c index 8f78d2d..efe6155
> 100644
> --- a/drivers/usb/phy/phy-twl4030-usb.c
> +++ b/drivers/usb/phy/phy-twl4030-usb.c
> @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct
> platform_device *pdev) if (device_create_file(&pdev->dev,
> &dev_attr_vbus)) dev_warn(&pdev->dev, "could not create sysfs
> file\n");
> 
> +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
> +
>  	/* Our job is to use irqs and status from the power module
>  	 * to keep the transceiver disabled when nothing's
> connected. *

I sent above patch week ago. Did you already included it?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130925/e77b7f6a/attachment.sig>

From: balbi@ti.com (Felipe Balbi)
Date: Tue, 17 Sep 2013 10:49:17 -0500
Subject: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <1378630239-10006-2-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-2-git-send-email-pali.rohar@gmail.com>
Message-ID: <20130917154917.GL15645@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh?r wrote:
> diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4030-usb.c
> index 8f78d2d..efe6155 100644
> --- a/drivers/usb/phy/phy-twl4030-usb.c
> +++ b/drivers/usb/phy/phy-twl4030-usb.c
> @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct platform_device *pdev)
>  	if (device_create_file(&pdev->dev, &dev_attr_vbus))
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  
> +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);

BTW, this is a bugfix, send separately.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130917/dde12078/attachment.sig>

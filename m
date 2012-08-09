From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Aug 2012 12:28:54 +0300
Subject: [PATCH v3 1/5] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <1344411661-17821-2-git-send-email-p.paneri@samsung.com>
References: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
 <1344411661-17821-2-git-send-email-p.paneri@samsung.com>
Message-ID: <20120809092853.GJ12174@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 01:10:57PM +0530, Praveen Paneri wrote:
> +static int __init samsung_usbphy_driver_init(void)
> +{
> +	return platform_driver_register(&samsung_usbphy_driver);
> +}
> +subsys_initcall(samsung_usbphy_driver_init);

let's make use of the module_platform_driver() and have dependent
drivers return -EPROBE_DEFER until this has registered.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120809/c83bf221/attachment.sig>

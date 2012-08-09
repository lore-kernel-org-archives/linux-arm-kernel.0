From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Aug 2012 12:29:39 +0300
Subject: [PATCH v3 2/5] usb: s3c-hsotg: Adding phy driver support
In-Reply-To: <1344411661-17821-3-git-send-email-p.paneri@samsung.com>
References: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
 <1344411661-17821-3-git-send-email-p.paneri@samsung.com>
Message-ID: <20120809092938.GK12174@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 01:10:58PM +0530, Praveen Paneri wrote:
> @@ -3689,6 +3706,9 @@ static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
>  	s3c_hsotg_phy_disable(hsotg);
>  	regulator_bulk_free(ARRAY_SIZE(hsotg->supplies), hsotg->supplies);
>  
> +	if (hsotg->phy)
> +		devm_usb_put_phy(&pdev->dev, hsotg->phy);

unnecessary. This will be called for you when the platform_device object
is detroyed.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120809/f4376439/attachment-0001.sig>

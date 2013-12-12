From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 14:56:40 -0600
Subject: [PATCH v5 1/2] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <1386877762-19115-1-git-send-email-w-kwok2@ti.com>
References: <1386877762-19115-1-git-send-email-w-kwok2@ti.com>
Message-ID: <20131212205640.GR1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 12, 2013 at 02:49:22PM -0500, WingMan Kwok wrote:
> +static int kdwc3_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
> +
> +	kdwc3_disable_irqs(kdwc);
> +	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);
> +	platform_set_drvdata(pdev, NULL);
> +	clk_disable_unprepare(kdwc->clk);
> +	return 0;

I had already fixed it in my branch, thaks anyway :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/15123dd5/attachment.sig>

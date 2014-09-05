From: balbi@ti.com (Felipe Balbi)
Date: Fri, 5 Sep 2014 10:47:01 -0500
Subject: [PATCH v6 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
In-Reply-To: <1409931392-22340-2-git-send-email-peter.griffin@linaro.org>
References: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
 <1409931392-22340-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140905154700.GE24449@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 05, 2014 at 04:36:30PM +0100, Peter Griffin wrote:
> +static int st_dwc3_remove_child(struct device *dev, void *c)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	of_device_unregister(pdev);
> +
> +	return 0;
> +}
> +
> +static int st_dwc3_remove(struct platform_device *pdev)
> +{
> +	struct st_dwc3 *dwc3_data = platform_get_drvdata(pdev);
> +
> +	device_for_each_child(&pdev->dev, NULL, st_dwc3_remove_child);

same as before, of_platform_depopulate(). I can fix this one myself this
time.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140905/8ac68a73/attachment.sig>

From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Sep 2014 15:15:49 -0500
Subject: [PATCH v5 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
In-Reply-To: <1409677729-6922-2-git-send-email-peter.griffin@linaro.org>
References: <1409677729-6922-1-git-send-email-peter.griffin@linaro.org>
 <1409677729-6922-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140903201549.GJ31855@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 02, 2014 at 06:08:47PM +0100, Peter Griffin wrote:
> +static int st_dwc3_remove(struct platform_device *pdev)
> +{
> +	struct st_dwc3 *dwc3_data = platform_get_drvdata(pdev);
> +
> +	device_for_each_child(&pdev->dev, NULL, st_dwc3_remove_child);

you might want to use of_platform_depopulate() instead :-) Sorry I
didn't notice this earlier.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140903/d8bcdd5c/attachment.sig>

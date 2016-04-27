From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 27 Apr 2016 12:34:07 +0300
Subject: [RESEND PATCH v2 6/7] usb: xhci: plat: add generic PHY support
In-Reply-To: <20160427075751.GA3540@kuha.fi.intel.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-7-git-send-email-jszhang@marvell.com>
 <20160427075751.GA3540@kuha.fi.intel.com>
Message-ID: <87twinmm40.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Heikki Krogerus <heikki.krogerus@linux.intel.com> writes:
> On Tue, Apr 26, 2016 at 08:57:39PM +0800, Jisheng Zhang wrote:
>> @@ -232,22 +265,44 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>>  		xhci->shared_hcd->can_do_streams = 1;
>>  
>> +	hcd->phy = devm_phy_get(&pdev->dev, "usb2-phy");
>> +	if (IS_ERR(hcd->phy)) {
>> +		ret = PTR_ERR(hcd->phy);
>> +		if (ret == -EPROBE_DEFER)
>> +			goto put_usb3_hcd;
>> +		hcd->phy = NULL;
>> +	}
>> +
>> +	phy = devm_phy_get(&pdev->dev, "usb-phy");
>
> "usb-phy" for what I understand is the USB3 PHY right?

that doesn't appear to be documented anywhere ;-)

> I was unable to find any definition for the phy names for example from
> Documentation/devicetree/bindings/usb/usb-xhci.txt, so I would say
> this needs to be "usb3-phy" and the phy names need to be defined
> somewhere.

yeah, usb3-phy sounds like a better name.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/4946e7f5/attachment.sig>

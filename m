From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 3 Dec 2013 19:43:37 +0530
Subject: [PATCH v2 2/7] usb: dwc3: adapt dwc3 core to use Generic PHY
 Framework
In-Reply-To: <20131203115927.GD26423@xps8300>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-3-git-send-email-kishon@ti.com>
 <20131203115927.GD26423@xps8300>
Message-ID: <529DE711.2090008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 03 December 2013 05:29 PM, Heikki Krogerus wrote:
> Hi Kishon,
> 
> On Wed, Oct 16, 2013 at 01:24:12AM +0530, Kishon Vijay Abraham I wrote:
>> +	count = of_property_match_string(node, "phy-names", "usb2-phy");
>> +	if (count >= 0 || (pdata && pdata->usb2_generic_phy)) {
>> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>> +		if (IS_ERR(dwc->usb2_generic_phy)) {
>> +			dev_err(dev, "no usb2 phy configured yet");
>> +			return PTR_ERR(dwc->usb2_generic_phy);
>> +		}
>> +		dwc->usb2_phy = NULL;
>> +	}
>> +
>> +	count = of_property_match_string(node, "phy-names", "usb3-phy");
>> +	if (count >= 0 || (pdata && pdata->usb3_generic_phy)) {
>> +		dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
>> +		if (IS_ERR(dwc->usb3_generic_phy)) {
>> +			dev_err(dev, "no usb3 phy configured yet");
>> +			return PTR_ERR(dwc->usb3_generic_phy);
>> +		}
>> +		dwc->usb3_phy = NULL;
>> +	}
> 
> Is there some specific reason for these checks? The driver should not
> need to care about the platform (DT, ACPI, platform based).

yeah just wanted to throw an error if a platform needs PHY but wasn't able to
get it. Btw this has changed after my v3 of this patch series which I sent
sometime back [1] where we use quirks to know if a PHY is needed for that
platform or not.

http://www.spinics.net/lists/linux-usb/msg98077.html

Thanks
Kishon

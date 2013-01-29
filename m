From: kishon@ti.com (kishon)
Date: Tue, 29 Jan 2013 19:40:23 +0530
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130129135336.GA3323@pengutronix.de>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com> <20130129135336.GA3323@pengutronix.de>
Message-ID: <5107D84F.80401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 07:23 PM, Wolfram Sang wrote:
>>> +	err = of_property_read_string(np, "phy_type", &phy_type);
>>> +	if (err < 0)
>>> +		return USBPHY_INTERFACE_MODE_NA;
>>
>> Why don't we use a u32 property type for the *phy-type*? IMHO we
>> should use string property only when the property should be
>> absolutely unambiguous (e.g., compatible property should be string).
>
> If we would use u32-numbers in the compatible entry, this would also be
> unambiguous, no? 0xd00dfeed would be the at24-driver. Pretty specific.

hehe... But we don't have a corresponding *enum* representing the 
drivers :-)
>
> I don't mind having readable devicetrees. And we have it for ethernet
> phys already with strings, so it would be consistent.

Ok. Fine with it then :-)

Thanks
Kishon

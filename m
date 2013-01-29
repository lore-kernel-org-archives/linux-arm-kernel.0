From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 10:10:37 -0700
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <5107D253.5030400@ti.com>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com>
Message-ID: <5108028D.5030605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 06:44 AM, kishon wrote:
> Hi,
> 
> On Tuesday 29 January 2013 04:52 PM, Sascha Hauer wrote:
>> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>> This adds two little devicetree helper functions for determining the
>> dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
>> the devicetree.

>> +/**
>> + * of_get_usbphy_mode - Get phy mode for given device_node
>> + * @np:    Pointer to the given device_node
>> + *
>> + * The function gets phy interface string from property 'phy_type',
>> + * and returns the correspondig enum usb_phy_interface
>> + */
>> +enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
>> +{
>> +    const char *phy_type;
>> +    int err, i;
>> +
>> +    err = of_property_read_string(np, "phy_type", &phy_type);
>> +    if (err < 0)
>> +        return USBPHY_INTERFACE_MODE_NA;
> 
> Why don't we use a u32 property type for the *phy-type*? IMHO we should
> use string property only when the property should be absolutely
> unambiguous (e.g., compatible property should be string).

Well, this DT property is already defined an in-use, so while a
different decision might (or might not) be made today about the property
name/content, it's already defined and widely in use, so can't really be
changed.

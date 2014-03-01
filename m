From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 01 Mar 2014 14:14:31 +0100
Subject: [linux-sunxi] Re: [PATCH v3 1/4] ARM: sunxi: Add driver for sunxi
 usb phy
In-Reply-To: <530B136E.8080702@ti.com>
References: <1393157352-21104-1-git-send-email-hdegoede@redhat.com>
 <1393157352-21104-2-git-send-email-hdegoede@redhat.com>
 <530B136E.8080702@ti.com>
Message-ID: <5311DD37.9000106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/24/2014 10:39 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Sunday 23 February 2014 05:39 PM, Hans de Goede wrote:
>> The Allwinner A1x / A2x SoCs have 2 or 3 usb phys which are all accessed
>> through a single set of registers. Besides this there are also some other
>> phy related bits which need poking, which are per phy, but shared between the
>> ohci and ehci controllers, so these are also controlled from this new phy
>> driver.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
<snip>

>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -64,4 +64,15 @@ config BCM_KONA_USB2_PHY
>>  	help
>>  	  Enable this to support the Broadcom Kona USB 2.0 PHY.
>>  
>> +config PHY_SUN4I_USB
>> +	tristate "Allwinner sunxi SoC USB PHY driver"
>> +	depends on ARCH_SUNXI
>> +	select GENERIC_PHY
> 
> recently some errors have been reported if you don't have depends on HAS_IOMEM.
> Also add depends on CONFIG_OF.

Fixed for v4.

<snip>

>> +		/* set the data bit and clear usbc bit*/
>> +		temp = readb(phy_data->base + REG_PHYCTL);
>> +		if (data & 0x1)
>> +			temp |= BIT(7);
> 
> From the comment, I assume it to be a data bit. Let's add a macro for it?
> 
> If you can fix these minor comments while changing the $subject (PHY: sunxi) it
> should be good to get merged.

All fixed for v4.

Regards,

Hans

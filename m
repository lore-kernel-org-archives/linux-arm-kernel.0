From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 15 Sep 2010 08:48:07 +1200
Subject: [PATCH v2] AT91: Add flexibity board support
In-Reply-To: <AANLkTi=-n0_uFMKGED-aOtuLEfUyVeMcm5FWX5xM_BT1@mail.gmail.com>
References: <4C8DFA84.4040501@gmail.com>	<4C8E8F31.2050108@bluewatersys.com>
	<AANLkTi=-n0_uFMKGED-aOtuLEfUyVeMcm5FWX5xM_BT1@mail.gmail.com>
Message-ID: <4C8FDF87.4050500@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2010 05:57 PM, Maxim Osipov wrote:
> Please see my comments below...
> 
> On Tue, Sep 14, 2010 at 12:53 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
>> On 09/13/2010 10:18 PM, Maxim Osipov wrote:
>>
>>> +static void __init flexibity_board_init(void)
>>> +{
>>> +     /* Serial */
>>> +     at91_add_device_serial();
>>> +     /* USB Host */
>>> +     at91_add_device_usbh(&flexibity_usbh_data);
>>> +     /* USB Device */
>>> +     at91_add_device_udc(&flexibity_udc_data);
>>> +     /* SPI */
>>> +     at91_add_device_spi(flexibity_spi_devices,
>>> +             ARRAY_SIZE(flexibity_spi_devices));
>>> +     /* MMC */
>>> +     at91_add_device_mmc(0, &flexibity_mmc_data);
>>> +     /* LEDs */
>>> +     at91_gpio_leds(flexibity_leds, ARRAY_SIZE(flexibity_leds));
>>
>> Can we drop all the comments inside this function please. They don't add
>> any information and they make it harder to read the actual code.
>>
> 
> Ryan, thank you for the review. However I would like to keep these
> comments - for some devices, like UDC - it really provides
> clarification. Reading the code is not a problem with proper
> highlighting scheme.

There are already comments above each of the structures so it is clear
what all of these are. IMHO, this commenting is similar to doing:

	/* Add 1 to i */
	i++;

We don't have this kind of overly verbose commenting in any of the other
ARM variants, it appears to something that is just cut and pasted around
the AT91 boards :-). Syntax highlighting or not, reading one for one
comments on what should be straight forward device registration is annoying.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934

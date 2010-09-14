From: maxim.osipov@gmail.com (Maxim Osipov)
Date: Tue, 14 Sep 2010 09:57:27 +0400
Subject: [PATCH v2] AT91: Add flexibity board support
In-Reply-To: <4C8E8F31.2050108@bluewatersys.com>
References: <4C8DFA84.4040501@gmail.com>
	<4C8E8F31.2050108@bluewatersys.com>
Message-ID: <AANLkTi=-n0_uFMKGED-aOtuLEfUyVeMcm5FWX5xM_BT1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please see my comments below...

On Tue, Sep 14, 2010 at 12:53 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> On 09/13/2010 10:18 PM, Maxim Osipov wrote:
>
>> +static void __init flexibity_board_init(void)
>> +{
>> + ? ? /* Serial */
>> + ? ? at91_add_device_serial();
>> + ? ? /* USB Host */
>> + ? ? at91_add_device_usbh(&flexibity_usbh_data);
>> + ? ? /* USB Device */
>> + ? ? at91_add_device_udc(&flexibity_udc_data);
>> + ? ? /* SPI */
>> + ? ? at91_add_device_spi(flexibity_spi_devices,
>> + ? ? ? ? ? ? ARRAY_SIZE(flexibity_spi_devices));
>> + ? ? /* MMC */
>> + ? ? at91_add_device_mmc(0, &flexibity_mmc_data);
>> + ? ? /* LEDs */
>> + ? ? at91_gpio_leds(flexibity_leds, ARRAY_SIZE(flexibity_leds));
>
> Can we drop all the comments inside this function please. They don't add
> any information and they make it harder to read the actual code.
>

Ryan, thank you for the review. However I would like to keep these
comments - for some devices, like UDC - it really provides
clarification. Reading the code is not a problem with proper
highlighting scheme.

Kind regards,
Maxim

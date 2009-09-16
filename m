From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Sep 2009 18:17:01 +0200
Subject: [PATCH 2/2] at91/USB: at91sam9g45 series USB host integration
In-Reply-To: <200906190226.56278.david-b@pacbell.net>
References: <1244547493-19654-1-git-send-email-nicolas.ferre@atmel.com>
	<200906190043.00428.david-b@pacbell.net>
	<20090619095148.67a74ed9@hskinnemoen-d830>
	<200906190226.56278.david-b@pacbell.net>
Message-ID: <4AB10F7D.9060706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I come back on this topic as at91sam9g45 is now in mainline. I need this
integration code to have the USB EHCI work on the evaluation kit.

David Brownell :
> On Friday 19 June 2009, Haavard Skinnemoen wrote:
>> David Brownell wrote:
>>>> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
>>>> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
>>>> +	/* Enable VBus control for UHP ports */
>>>> +	for (i = 0; i < data->ports; i++) {
>>>> +		if (data->vbus_pin[i])
>>>> +			at91_set_gpio_output(data->vbus_pin[i], 0);  
>>> This should gpio_request() and gpio_direction_output().
>> Hmm...I thought the driver was supposed to call gpio_request(), not the
>> platform code?
> 
> In some cases.  This isn't a good case for that.  Especially
> if it's going to call gpio_direction_output() ... which needs
> gpio_request() to have been done first.

Ok, I am building a patch on top of this one that uses these calls. This
way I can change both vbus pin configuration: OCHI and EHCI.

Best regards,
-- 
Nicolas Ferre

From: plyatov@gmail.com (Igor Plyatov)
Date: Fri, 22 Apr 2011 09:00:13 +0400
Subject: [PATCH] mach-at91: gsia18s board improvements and bug fixes
In-Reply-To: <4DB04588.9000201@atmel.com>
References: <1303291399-4075-1-git-send-email-plyatov@gmail.com>
	<4DB04588.9000201@atmel.com>
Message-ID: <4DB10B5D.1020602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas!
> Hi Igor,
>
> Le 20/04/2011 11:23, Igor Plyatov :
>> * AT91_PIN_Pxxx port names replaced by human readable GPO_xxxx, GPI_xxxx,
>>    GPIO_xxxx names. This simplify source code and schematic maintenance.
> Maybe it simplifies schematic reading because the actual cpu pin names
> are not indicated on your schematic... But for code, the AT91 pin names
> are required, so, no for this part of the patch.
> You may know that there is an effort ongoing to minimize the amount of
> not needed / duplicated information in the kernel, I am afraid but I
> think this renaming is not needed.
>
> Moreover, I think that the "Buttons" part of the file:
> arch/arm/mach-at91/include/mach/gsia18s.h
> should be removed.

OK. Corrected.

>> * Active logic levels and default states corrected for GPOs.
> Ok for this.
>
>> * Replace small functions which use platform_register_device() by its direct
>>    calls.
> Ok for this.
>
>> * Remove GPIO_CARD_UNMOUNT_1 gpio_keys_button, because it not used.
> Ok for this.
>
>> * debounce_interval added for critical buttons.
> Ok for this.
>
>> * Remove unneeded GPI setup code for buttons, because this done by corresponding
>>    driver.
> I do not see this, can you elaborate?

The "gsia18s_add_device_buttons" function removed, because GPIs 
initialization done by "gpio_keys" driver and this function replaced by 
"platform_register_device" direct call.

>> * pcf8574x_0x20_setup() and pcf8574x_0x20_teardown functions small refactoring.
> Ok for this.
>
>> Signed-off-by: Igor Plyatov<plyatov@gmail.com>
> So, can you please rewrite your patch, we will be pleased to integrate
> it in a "fix" update of at91 Linux.
>
> Thanks, best regards,

Rewritten and will be published as "[PATCH v2] mach-at91: gsia18s board 
improvements and bug fixes".

Best regards!

-- 
Igor Plyatov

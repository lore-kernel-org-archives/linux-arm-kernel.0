From: hong.xu@atmel.com (Hong Xu)
Date: Wed, 25 May 2011 17:15:53 +0800
Subject: [PATCH] AT91: Add VSYNC pin definition for AT91SAM9263 silicon
In-Reply-To: <20110525073933.GH863@game.jcrosoft.org>
References: <1306305101-27285-1-git-send-email-hong.xu@atmel.com>
	<20110525073933.GH863@game.jcrosoft.org>
Message-ID: <4DDCC8C9.3080102@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/25/2011 03:39 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:31 Wed 25 May     , Hong Xu wrote:
>> On Atmel's AT91SAM9263-EK board, the LCD panel does not need VSYNC
>> signal. But this signal is useful for the boards from other
>> vendors, as suggested by Nicholas Kinar.
>>
>> This small patch adds the VSYNC pin definition by default.
>>
>> Reported-by: Nicholas Kinar<n.kinar@usask.ca>
>> Signed-off-by: Hong Xu<hong.xu@atmel.com>
>> ---
>>   arch/arm/mach-at91/at91sam9263_devices.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
>> index fb5c23a..7dab33e 100644
>> --- a/arch/arm/mach-at91/at91sam9263_devices.c
>> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
>> @@ -832,6 +832,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
>>   	if (!data)
>>   		return;
>>
>> +	at91_set_A_periph(AT91_PIN_PC0, 0);	/* LCDVSYNC */
> this must be optionnal
>
> we need to update this with somethink like done on avr32
>

hm.. PC0 in SAM9263 has only "A" function (LCD VSYNC). As long as this 
pin is not used as GPIO, it's harmless to enable its peripheral function.

I just had a quick look at the AVR32 code without catching your 
"something like on AVR32". In AVR32, all ATMEL_LCDC_*_*BIT has "VSYNC" 
defined.

BR,
Eric

From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 01 Apr 2011 18:50:48 +0400
Subject: [PATCH 2/7] mioa701: drop udc_is_connected
In-Reply-To: <4D95DCD9.80007@ru.mvista.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
	<1301666188-11822-2-git-send-email-dbaryshkov@gmail.com>
	<4D95DCD9.80007@ru.mvista.com>
Message-ID: <4D95E648.5000906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.04.2011 18:10, Sergei Shtylyov wrote:
> Dmitry Eremin-Solenikov wrote:
>
>> Mioa701 is a pxa270 machine and pxa27x_udc driver doesn't pay any
>> attention
>> to udc_is_connected, so drop it.
>
> You seem to be moving is_usb_connected(), not dropping it...

It may seem to be a bad wording. I'm dropping 
pxa2xx_udc_mach_info.udc_is_connected() callback assignment. The 
is_usb_connected() function is still used by pda-power driver.

>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>> arch/arm/mach-pxa/mioa701.c | 11 +++++------
>> 1 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
>> index dd13bb6..f69a3c7 100644
>> --- a/arch/arm/mach-pxa/mioa701.c
>> +++ b/arch/arm/mach-pxa/mioa701.c
>> @@ -402,13 +402,7 @@ static void gsm_exit(void)
>> /*
>> * USB UDC
>> */
>> -static int is_usb_connected(void)
>> -{
>> - return !gpio_get_value(GPIO13_nUSB_DETECT);
>> -}
>> -
>> static struct pxa2xx_udc_mach_info mioa701_udc_info = {
>> - .udc_is_connected = is_usb_connected,
>> .gpio_pullup = GPIO22_USB_ENABLE,
>> };
>>
>> @@ -596,6 +590,11 @@ static int is_ac_connected(void)
>> return gpio_get_value(GPIO96_AC_DETECT);
>> }
>>
>> +static int is_usb_connected(void)
>> +{
>> + return !gpio_get_value(GPIO13_nUSB_DETECT);
>> +}
>> +
>> static void mioa701_set_charge(int flags)
>> {
>> gpio_set_value(GPIO9_CHARGE_EN, (flags == PDA_POWER_CHARGE_USB));
>
> WBR, Sergei


-- 
With best wishes
Dmitry

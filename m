From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 25 Oct 2013 13:25:12 +0300
Subject: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
In-Reply-To: <526A4585.30403@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
 <526A4585.30403@ti.com>
Message-ID: <526A4708.7010309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/13 13:18, Nishanth Menon wrote:

>>  void __init omap_4430sdp_display_init_of(void)
>>  {
>> -	int r;
>> -
>> -	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
>> -			"display_sel");
>> -	if (r)
>> -		pr_err("%s: Could not get display_sel GPIO\n", __func__);
>> -
>> -	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
>> -		"DLP POWER ON");
>> -	if (r)
>> -		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
>> -
>>  	omap_display_init(&sdp4430_dss_data);
>>  
>>  	platform_device_register(&sdp4430_lcd_device);
>>
> would you not be depending on the weak IO pull done using mux to drive
> these GPIO pins since the GPIO is not requested and held?

Yes. Is that not enough?

> Could we not use Documentation/devicetree/bindings/gpio/gpio.txt
> binding to map to the right GPIO and drive it using the GPIO module?

Hmm, what do you mean?

I do mux the pins to gpios, but there's nothing in the kernel that would
use those gpios. That's why we had the hack above, but I'd love to get
rid of it.

Can I set the pins to GPIO mode, and set the GPIO to high/low in the .dts?

If things were perfect, we probably would have a driver for the "switch"
part. I have no idea what kind of driver that would be, though, so at
the moment we've just gone with the use-LCD2-by-default route.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/b14d1d18/attachment.sig>

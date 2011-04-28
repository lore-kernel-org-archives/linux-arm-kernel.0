From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 28 Apr 2011 13:03:26 -0300
Subject: [PATCH 2/2] ARM: mx5/mx51_babbage: Use gpio_request_one when
	possible
In-Reply-To: <20110428075500.GM31131@pengutronix.de>
References: <1303951472-22234-1-git-send-email-festevam@gmail.com>
	<1303951472-22234-2-git-send-email-festevam@gmail.com>
	<20110428075500.GM31131@pengutronix.de>
Message-ID: <4DB98FCE.8090706@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 4/28/2011 4:55 AM, Uwe Kleine-K?nig wrote:
...
  
>>  	/* Set USBH1_STP to GPIO and toggle it */
>>  	mxc_iomux_v3_setup_pad(usbh1stp_gpio);
> This cannot go into the global list of pins to mux?

This pin alternates its mode(GPIO and USB STP), so I think we can leave it defined here.
> 
>> -	ret = gpio_request(BABBAGE_USBH1_STP, "usbh1_stp");
>> +	ret = gpio_request_one(BABBAGE_USBH1_STP,
>> +					GPIOF_OUT_INIT_LOW, "usbh1_stp");
>>  
>>  	if (ret) {
>>  		pr_debug("failed to get MX51_PAD_USBH1_STP__GPIO_1_27: %d\n", ret);
>>  		return ret;
>>  	}
>> -	gpio_direction_output(BABBAGE_USBH1_STP, 0);
>>  	gpio_set_value(BABBAGE_USBH1_STP, 1);
>>  	msleep(100);
> Why is the sleep between set_value(1) and free? I would have expected it
> between request_one(INIT_LOW) and set_value(1)?

Agreed. I haven?t changed the logic on this patch. Will send a third patch for fixing this.

Thanks,

Fabio Estevam

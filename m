From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 15 Jul 2013 13:33:53 +0200
Subject: [PATCH v3 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
In-Reply-To: <2A7ABDFCE21540479A5AEB0244A684D5E3D067@DNCE04.ent.ti.com>
References: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com>
 <1373613482-28390-3-git-send-email-oleksandr.kozaruk@ti.com>,
 <51E05F6C.1060506@metafoo.de>
 <2A7ABDFCE21540479A5AEB0244A684D5E3D067@DNCE04.ent.ti.com>
Message-ID: <51E3DE21.9060105@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 01:09 PM, Kozaruk, Oleksandr wrote:
[...]
> 
>>> +     ret = devm_request_threaded_irq(dev, irq, NULL,
>>> +                                     twl6030_gpadc_irq_handler,
>>> +                                     IRQF_ONESHOT, "twl6030_gpadc", gpadc);
>>
>> You access memory in the interrupt handler which is freed before the interrupt
>> handler is freed.
> Thanks for pointing this. devm_* will free memory for irq after the driver
> is removed and memory for the device is freed. I took me awhile to understand
> this. Is there going to be something like devm_iio_device_alloc? whould it be helpfull?
> 

Yes, I think it certainly makes sense to add a devm_iio_device_alloc(), care
to send a patch?

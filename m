From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 13 Jan 2017 15:52:00 +0100
Subject: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
In-Reply-To: <20170113083727.GB1446@katana>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
 <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
 <469bf72b-70e6-24d2-99b1-79b6f0a635bb@topic.nl>
 <20170113083727.GB1446@katana>
Message-ID: <5d1b0fda-38e7-c4bd-46de-318507525c8b@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 13-01-17 09:37, Wolfram Sang wrote:
>
>> I would argue that the "info" message means "the I2C adapter is ready for
>> transaction now, and we'll start initializing devices on the bus". That is
>> the case before it calls i2c_add_adapter().
>
> I know what you mean, but i2c_add_adapter does more, and it can fail
> because the adapter is *not* ready to transfer. Seeing the success
> message before is also confusing.
>
>> When i2c_add_adapter() runs, it will start probing devices on the bus. This
>> yields very confusing output, as it will output things in a reversed order:
>>
>> - device X on I2C bus
>> - device Y on I2C bus
>> - cdns-i2c ff030000.i2c: 100 kHz mmio ff030000 irq 197
>
> I agree. That being said, somewhen I started working on moving such
> messages into the core to save string space and have consistent output.
> Then, we can print at the proper time.
>
> So, until then, we should be consistent with the other driver, I'd say.

Makes sense.

I'll create a v2 patch to just move the i2c_add_adapter to after writing the 
configuration registers, and leave the dmesg output as is.

Thanks for reviewing,
Mike.


Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail

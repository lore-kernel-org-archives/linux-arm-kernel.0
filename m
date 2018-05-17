From: daniel@zonque.org (Daniel Mack)
Date: Thu, 17 May 2018 10:48:20 +0200
Subject: [PATCH 1/3] input: touchscreen: edt-ft5x06: make wakeup source
 behavior configurable
In-Reply-To: <20180516170333.GA21971@dtor-ws>
References: <20180516122829.23694-1-daniel@zonque.org>
 <20180516122829.23694-2-daniel@zonque.org> <20180516170333.GA21971@dtor-ws>
Message-ID: <3a6eb6a2-8a55-e4d8-f495-fd0d80d95de6@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On Wednesday, May 16, 2018 07:03 PM, Dmitry Torokhov wrote:
>> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
>> index 5bf63f76ddda..955f085627fa 100644
>> --- a/drivers/input/touchscreen/edt-ft5x06.c
>> +++ b/drivers/input/touchscreen/edt-ft5x06.c
>> @@ -1007,7 +1007,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>>   		goto err_remove_attrs;
>>   
>>   	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
>> -	device_init_wakeup(&client->dev, 1);
>> +	device_init_wakeup(&client->dev,
>> +			    device_property_read_bool(dev, "wakeup-source"));
> 
> I think we should actually drop device_init_wakeup() call. I2C core
> already handles "wakeup-source" property (for OF). The static board
> files can instantiate clients with I2C_CLIENT_WAKE, so that's handled
> too, and I think ACPI has its own notion of annotating wakeup sources.

Ah, right! Thanks, will respin :)


Daniel

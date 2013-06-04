From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 04 Jun 2013 08:54:23 +0200
Subject: [PATCHv3 1/3] Add support for GMT G762/G763 PWM fan controller
References: <cover.1370202835.git.arno@natisbad.org>
 <a7bfda1de9cce8044434369428341d3fb05cf42c.1370202835.git.arno@natisbad.org>
 <20130603023444.GB11723@roeck-us.net>
Message-ID: <87li6qz7q8.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Guenter Roeck <linux@roeck-us.net> writes:

> On Sun, Jun 02, 2013 at 10:14:19PM +0200, Arnaud Ebalard wrote:
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
>>  drivers/hwmon/Kconfig              |   10 +
>>  drivers/hwmon/Makefile             |    1 +
>>  drivers/hwmon/g762.c               | 1179 ++++++++++++++++++++++++++++++++++++
>>  include/linux/platform_data/g762.h |   51 ++
>>  4 files changed, 1241 insertions(+)
>>  create mode 100644 drivers/hwmon/g762.c
>>  create mode 100644 include/linux/platform_data/g762.h
>> 
> [ ... ]
>
>> +static inline int g762_read_byte(const struct i2c_client *client, u8 reg,
>> +				 u8 *dest)
>> +{
>> +	int ret;
>> +
>> +	ret = i2c_smbus_read_byte_data(client, reg);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "failed to read reg %x02x, err %d\n",
>> +			(int)reg, ret);
>
> I would suggest to write a piece of test code for the above statement and
> observe its output. "printf("%x02x\n", 0x1234);" should do.

good catch. s/%x02x/0x%02x/.

> Is the error message really needed ? If there is a persistent error,
> it will clog the log.

I removed it in v4 to come.

Cheers,

a+

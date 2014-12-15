From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 15 Dec 2014 11:28:20 +0800
Subject: [PATCH 1/3] ASoC: codecs: wm8904: add dt ids table
In-Reply-To: <20141212132321.GI11764@sirena.org.uk>
References: <1418267681-4091-1-git-send-email-voice.shen@atmel.com>
 <20141212132321.GI11764@sirena.org.uk>
Message-ID: <548E5554.6050900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 12/12/2014 09:23 PM, Mark Brown wrote:
> On Thu, Dec 11, 2014 at 11:14:39AM +0800, Bo Shen wrote:
>
>> +static const struct of_device_id wm8904_of_match[] = {
>> +	{ .compatible = "wlf,wm8904", },
>> +	{ .compatible = "wlf,wm8912", },
>> +	{ .compatible = "wlf,wm8918", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, wm8904_of_match);
>> +
>>   static struct i2c_driver wm8904_i2c_driver = {
>>   	.driver = {
>>   		.name = "wm8904",
>>   		.owner = THIS_MODULE,
>> +		.of_match_table = wm8904_of_match,
>
> I'm not seeing anything here that ensures that devtype is set correctly
> when probing using the OF IDs - currently we rely on i2c->driver_data.
>

I will add it in v2 patch.
Thanks.

Best Regards,
Bo Shen

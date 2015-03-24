From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 24 Mar 2015 23:05:59 +0000
Subject: [PATCH v3 1/9] regmap: Introduce regmap_get_max_register.
In-Reply-To: <20150324223637.GB28997@sirena.org.uk>
References: <1427236116-18531-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427236179-18580-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150324223637.GB28997@sirena.org.uk>
Message-ID: <5511EDD7.40202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/03/15 22:36, Mark Brown wrote:
> On Tue, Mar 24, 2015 at 10:29:39PM +0000, Srinivas Kandagatla wrote:
>
>> This patch introduces regmap_get_max_register() function which would be
>> used by the infrastructures like eeprom framework built on top of
>> regmap.
>
> In what way would it be used?
Its used in 2 purposes
1> It is used for sanity check purposes of the register ranges provided 
via DT/non-DT eeprom data cells.

2> To stop user reading when eeprom binary from /sys/class/eeprom/*/eeprom

>
>> +int regmap_get_max_register(struct regmap *map)
>> +{
>> +	return map->max_register ? : -EINVAL;
>> +}
>
> Please write the logic out properly, don't abuse the ternery operator.
Am happy to change it to your preference in next version, but this GNU 
extensions widely used in the kernel

$  grep -rR "return.*? :" ./linux | wc -l

115


>

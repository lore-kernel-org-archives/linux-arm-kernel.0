From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 19 Sep 2016 16:51:55 +0100
Subject: [PATCH v3 4/8] scpi: Add support for Legacy match table for
 Amlogic GXBB SoC
In-Reply-To: <6698b7b9-6ffc-d120-be9c-851ea0be2bf2@arm.com>
References: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
 <1473262477-18045-5-git-send-email-narmstrong@baylibre.com>
 <6698b7b9-6ffc-d120-be9c-851ea0be2bf2@arm.com>
Message-ID: <e183632f-66e0-d3dc-03f4-10df61374194@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/09/16 16:50, Sudeep Holla wrote:
>
>
> On 07/09/16 16:34, Neil Armstrong wrote:
>> Add new DT match table to setup the is_legacy boolean value across
>> the scpi functions.
>> Add the Amlogic GXBB SoC compatible for platform and as legacy match
>> entry.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/firmware/arm_scpi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>> index 6a16100..60a76e63 100644
>> --- a/drivers/firmware/arm_scpi.c
>> +++ b/drivers/firmware/arm_scpi.c
>> @@ -979,6 +979,11 @@ static int scpi_alloc_xfer_list(struct device
>> *dev, struct scpi_chan *ch)
>>      return 0;
>>  }
>>
>> +static const struct of_device_id legacy_scpi_of_match[] = {
>> +    {.compatible = "amlogic,meson-gxbb-scpi"},
>> +    {},
>> +};
>
> This needs to be documented.
>

Ignore that I see you have done that in the later patch.

-- 
Regards,
Sudeep

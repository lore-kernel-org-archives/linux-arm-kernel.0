From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Sun, 16 Jul 2017 23:12:15 -0500
Subject: [PATCH] pinctrl: bcm2835: constify gpio_chip structure
In-Reply-To: <877ezdh3jn.fsf@eliezer.anholt.net>
References: <20170711180339.GA17806@embeddedgus>
 <877ezdh3jn.fsf@eliezer.anholt.net>
Message-ID: <e2e1909e-9a8a-9fc5-a002-b8597cef6b64@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/12/2017 02:13 PM, Eric Anholt wrote:
> "Gustavo A. R. Silva" <garsilva@embeddedor.com> writes:
>
>> This structure is only used to copy into other structure, so declare
>> it as const.
>>
>> This issue was detected using Coccinelle and the following semantic patch:
> Acked-by: Eric Anholt <eric@anholt.net>

Thank you, Eric

>> ---
>>   drivers/pinctrl/bcm/pinctrl-bcm2835.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>> index 2308831..7203f35 100644
>> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>> @@ -353,7 +353,7 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
>>   	return pinctrl_gpio_direction_output(chip->base + offset);
>>   }
>>   
>> -static struct gpio_chip bcm2835_gpio_chip = {
>> +static const struct gpio_chip bcm2835_gpio_chip = {
>>   	.label = MODULE_NAME,
>>   	.owner = THIS_MODULE,
>>   	.request = gpiochip_generic_request,
>> -- 
>> 2.5.0

-- 
Gustavo A. R. Silva

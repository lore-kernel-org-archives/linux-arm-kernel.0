From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 16 Jun 2016 15:22:37 +0530
Subject: [PATCH 4/5] clk: max77686: Add support for MAX77620 clocks
In-Reply-To: <57627757.50101@samsung.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-5-git-send-email-ldewangan@nvidia.com>
 <57627757.50101@samsung.com>
Message-ID: <576276E5.5040500@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof/Javier,
Thanks for review of the series.

I will post the V2 after taking care of all comment.

One query about the comment.

Thanks,
Laxman

On Thursday 16 June 2016 03:24 PM, Krzysztof Kozlowski wrote:
> On 06/15/2016 04:13 PM, Laxman Dewangan wrote:
>>   enum chip_name {
>>   	CHIP_MAX77686,
>>   	CHIP_MAX77802,
>> +	CHIP_MAX77620,
> Now it is more obvious why it is here. However I don't like the
> duplication of device IDs, under different names and different values:
> 1. include/linux/mfd/max77686-private.h
> 2. include/linux/mfd/max77620.h
> 3. here
>
> I was thinking about way of combining it... but these headers are
> different. Unless there will be one header for all three devices.
>
> Anyway, please add the max77686 prefix to the enum.

so will it be:

enum max77686_chip_name {
     CHIP_MAX77686,
     CHIP_MAX77802,
     CHIP_MAX77620,
};


Will it be fine here?

From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri, 07 Feb 2014 11:39:49 +0100
Subject: [PATCH] clk: at91: remove redundant assignment
In-Reply-To: <52F4AF3F.7040809@atmel.com>
References: <1391712790-13591-1-git-send-email-colin.king@canonical.com>
 <52F4AF3F.7040809@atmel.com>
Message-ID: <52F4B7F5.5020704@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas, Colin,

On 07/02/2014 11:02, Nicolas Ferre wrote:
> On 06/02/2014 19:53, Colin King :
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> remove the redundant shift = shift assignment, it is extraneous.
Thanks for reporting and fixing this.

>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Thanks.
>
> Boris, can you integrate this patch to the "fixes" series that will be
> sent to Mike during the 3.14 development cycle?

The round_rate function has been replaced by determine_rate and thus the 
bug is not present anymore.

See JJ's series: 
http://us.generation-nt.com/patch-v2-0-4-clk-at91-better-support-pcks-help-213900572.html

Best Regards,

Boris

> Bye,
>
>> ---
>>   drivers/clk/at91/clk-programmable.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
>> index fd792b2..ff86efe 100644
>> --- a/drivers/clk/at91/clk-programmable.c
>> +++ b/drivers/clk/at91/clk-programmable.c
>> @@ -109,7 +109,7 @@ static long clk_programmable_round_rate(struct clk_hw *hw, unsigned long rate,
>>   	unsigned long best_diff;
>>   	unsigned long new_diff;
>>   	unsigned long cur_rate;
>> -	int shift = shift;
>> +	int shift;
>>   
>>   	if (rate > *parent_rate)
>>   		return *parent_rate;
>>
>

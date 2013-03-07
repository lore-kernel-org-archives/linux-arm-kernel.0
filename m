From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 7 Mar 2013 15:05:58 +0530
Subject: [PATCH 1/1] clk: tegra: Fix periph_clk_to_bit macro
In-Reply-To: <5137BC29.2030909@wwwdotorg.org>
References: <1362606444-19970-1-git-send-email-achew@nvidia.com>
 <5137BC29.2030909@wwwdotorg.org>
Message-ID: <51385F7E.9050503@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 March 2013 03:29 AM, Stephen Warren wrote:
> On 03/06/2013 02:47 PM, Andrew Chew wrote:
>> The parameter name should be "gate", not "periph".  This worked, however,
>> because it happens that everywhere periph_clk_to_bit is called, "gate" was
>> in the local scope.
> Peter, Prashant, can I get an ack/reviewed-by please?

Thanks for the fix!!

Reviewed-by: Prashant Gaikwad <pgaikwad@nvidia.com>

> Note: I'm also CC'ing Mike and the LAKML mailing list; common clock
> driver changes should be sent to Mike as CCF maintainer, and any
> ARM-related changes should typically get sent to LAKML in the absence of
> any other specific subsystem list.
>
>> Signed-off-by: Yen Lin <yelin@nvidia.com>
>> Signed-off-by: Andrew Chew <achew@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-periph-gate.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/tegra/clk-periph-gate.c b/drivers/clk/tegra/clk-periph-gate.c
>> index 6dd5332..d87e1ce 100644
>> --- a/drivers/clk/tegra/clk-periph-gate.c
>> +++ b/drivers/clk/tegra/clk-periph-gate.c
>> @@ -41,7 +41,7 @@ static DEFINE_SPINLOCK(periph_ref_lock);
>>   #define write_rst_clr(val, gate) \
>>   	writel_relaxed(val, gate->clk_base + (gate->regs->rst_clr_reg))
>>   
>> -#define periph_clk_to_bit(periph) (1 << (gate->clk_num % 32))
>> +#define periph_clk_to_bit(gate) (1 << (gate->clk_num % 32))
>>   
>>   /* Peripheral gate clock ops */
>>   static int clk_periph_is_enabled(struct clk_hw *hw)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 26 Jun 2018 09:52:23 +0100
Subject: [PATCH 05/11] ASoC: qdsp6: q6asm: use
 of_platform_populate/depopulate()
In-Reply-To: <20180625180159.GD10876@centauri.lan>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-6-srinivas.kandagatla@linaro.org>
 <20180625180159.GD10876@centauri.lan>
Message-ID: <b5a41a84-162b-62dd-271c-066e42370a3e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/06/18 19:01, Niklas Cassel wrote:
> On Mon, Jun 25, 2018 at 03:31:09PM +0100, Srinivas Kandagatla wrote:
>> Now that the child nodes have there own compatible strings,
>> Use of_platform_populate/depopulate() instead of less common
>> of_platform_device_create()/destroy().
>>
>> Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6asm.c | 17 ++---------------
>>   1 file changed, 2 insertions(+), 15 deletions(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
>> index 530852385cad..2b2c7233bb5f 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm.c
>> +++ b/sound/soc/qcom/qdsp6/q6asm.c
>> @@ -174,10 +174,8 @@ struct q6asm {
>>   	struct device *dev;
>>   	struct q6core_svc_api_info ainfo;
>>   	wait_queue_head_t mem_wait;
>> -	struct platform_device *pcmdev;
> Why is this removed?
> If it's a cleanup, perhaps it should be in a separate patch.
Thanks, I will move this to a separate patch.
--srini
> 

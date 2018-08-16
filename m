From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Aug 2018 16:50:25 +0100
Subject: [PATCH 1/2] coresight: etb10: Refactor etb_drvdata::mode handling
In-Reply-To: <20180816154817.GA14955@xps15>
References: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
 <5cd6b8a8-2370-517d-deb1-378bff6e362b@arm.com> <20180816154817.GA14955@xps15>
Message-ID: <0796196d-f969-1e87-418b-bd67d4f5bf63@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/18 16:48, Mathieu Poirier wrote:
> On Thu, Aug 16, 2018 at 04:13:03PM +0100, Suzuki K Poulose wrote:
>> Hi Mathieu,
>>
>> The patch looks good to me. One minor nit below.
> 
> You have not included any comment - did you change your mind?
> 

Sorry, yes I did. It was about folding the checks where ETB is already
enabled in SYSFS.

>>
>> On 14/08/18 23:14, Mathieu Poirier wrote:
>>> This patch moves the etb_drvdata::mode from a locat_t to a simple u32,
>>> as it is for the ETF and ETR drivers.  This streamlines the code and adds
>>> commonality with the other drivers when dealing with similar operations.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-etb10.c | 62 +++++++++++++++------------
>>>   1 file changed, 34 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>>> index 9fd77fdc1244..69287163ce4e 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>>
>>> @@ -488,7 +494,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
>>>   	unsigned long flags;
>>>   	spin_lock_irqsave(&drvdata->spinlock, flags);
>>> -	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
>>> +	if (drvdata->mode == CS_MODE_SYSFS) {
>>>   		etb_disable_hw(drvdata);
>>>   		etb_dump_hw(drvdata);
>>>   		etb_enable_hw(drvdata);
>>
>> Looks good to me.
>>
>> Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki

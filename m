From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Fri, 23 Jun 2017 07:26:18 +0000
Subject: [PATCH 01/14] staging: fsl-mc: drop macros with possible side
 effects
In-Reply-To: <1498147673.24295.6.camel@perches.com>
References: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
 <20170622133600.31694-2-laurentiu.tudor@nxp.com>
 <1498147673.24295.6.camel@perches.com>
Message-ID: <594CC299.6010308@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On 06/22/2017 07:07 PM, Joe Perches wrote:
> On Thu, 2017-06-22 at 16:35 +0300, laurentiu.tudor at nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Several macros were triggering this checkpatch.pl warning:
>>    "Macro argument reuse '$arg' - possible side-effects?"
>> Fix the warning by turning them into real functions.
>
> good idea and
>
>> diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
> []
>> +static bool fsl_mc_device_match(struct fsl_mc_device *mc_dev,
>> +				struct dprc_obj_desc *obj_desc)
>> +{
>> +	return !strcmp(mc_dev->obj_desc.type, obj_desc->type) &&
>> +		mc_dev->obj_desc.id == obj_desc->id;
>> +}
>
> I'd reverse the test order and do the strcmp after the comparison
>
> 	return mc_dev->obj_desc.id == obj_desc->id &&
> 	       !strcmp(mc_dev->obj_desc.type, obj_desc->type);
>
> []
>
>> +static bool __must_check fsl_mc_is_allocatable(const char *obj_type)
>> +{
>> +	return strcmp(obj_type, "dpbp") == 0 ||
>> +	       strcmp(obj_type, "dpmcp") == 0 ||
>> +	       strcmp(obj_type, "dpcon") == 0;
>> +}
>
> please be consistent in using either == 0 or !
> when using strcmp
>

Thanks for the suggestions. Will take care of them in the next round.

---
Best Regards, Laurentiu

From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 13 Jun 2017 18:56:31 +0100
Subject: [PATCH 01/12] coresight replicator: Cleanup programmable
 replicator naming
In-Reply-To: <20170613165528.GA6392@xps15>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-2-git-send-email-suzuki.poulose@arm.com>
 <20170613165528.GA6392@xps15>
Message-ID: <92dd4d1f-171c-905c-13a3-80cd9663bbbf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/17 17:55, Mathieu Poirier wrote:
> On Mon, Jun 12, 2017 at 03:36:40PM +0100, Suzuki K Poulose wrote:
>> The Linux coresight drivers define the programmable ATB replicator as
>> Qualcom replicator, while this is designed by ARM. This can cause confusion
>> to a user selecting the driver. Cleanup all references to make it
>>  explicitly clear. This patch :
>>
>>  1) Adds a new compatible string for the same, retaining the old one for
>>     compatibility.
>>  2) Changes the Kconfig symbol (since this is not part of any defconfigs)
>> 	 CORESIGHT_QCOM_REPLICATOR => CORESIGHT_DYNAMIC_REPLICATOR
>>  3) Improves the help message in the Kconfig.
>>  4) Changes the name of the driver :
>> 	coresight-replicator-qcom => coresight-dynamic-replicator
>>
>> Cc: Pratik Patel <pratikp@codeaurora.org>
>> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: devicetree at vger.kernel.org
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Hi Suzuki,
>
>> ---
>>  Documentation/devicetree/bindings/arm/coresight.txt     |  4 +++-
>>  drivers/hwtracing/coresight/Kconfig                     | 10 +++++-----
>>  drivers/hwtracing/coresight/Makefile                    |  2 +-
>>  drivers/hwtracing/coresight/coresight-replicator-qcom.c |  2 +-
>>  4 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> index fcbae6a..f77329f 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -34,7 +34,9 @@ its hardware characteristcs.
>>  		- Embedded Trace Macrocell (version 4.x):
>>  			"arm,coresight-etm4x", "arm,primecell";
>>
>> -		- Qualcomm Configurable Replicator (version 1.x):
>> +		- Coresight programmable Replicator (version 1.x):
>> +			"arm,coresight-dynamic-replicator", "arm,primecell";
>> +				OR
>>  			"qcom,coresight-replicator1x", "arm,primecell";
>
> Rob, what's your view on keeping the old binding around?  We could simply change
> the two occurences we find in the DTs (Juno and 410c) to the new name and be
> done with the old one.

...

>> --- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
>> +++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
>
> While at it, I would also change the name of the file.

Sure, will do.

Thanks
Suzuki

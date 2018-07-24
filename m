From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Tue, 24 Jul 2018 17:25:22 -0500
Subject: [PATCH 1/3] Docs: dt: arm-smmu: Add optional clock parameter
In-Reply-To: <20180720161507.GA24992@rob-hp-laptop>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
 <1531499278-32132-2-git-send-email-thor.thayer@linux.intel.com>
 <20180720161507.GA24992@rob-hp-laptop>
Message-ID: <7a8041ff-ce54-6640-9c9b-d018b0534ff8@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 07/20/2018 11:15 AM, Rob Herring wrote:
> On Fri, Jul 13, 2018 at 11:27:56AM -0500, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add a clock to the SMMU node bindings.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 8a6ffce12af5..356fd9f41e1b 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -71,6 +71,8 @@ conditions.
>>                     or using stream matching with #iommu-cells = <2>, and
>>                     may be ignored if present in such cases.
>>   
>> +- clock:          clock provider specifier
>> +
> 
> The TRM says there is a TCU clock and clock per TBU.
> 
> Rob
> 
Yes, good point. I'm abandoning this review and will use the bulk clock 
suggested in [1].

In our case, the TCU clock is always on and we have 1 clock for the
TBU masters.

Thanks for reviewing!

Thor

[1] https://patchwork.kernel.org/patch/10534089/

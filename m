From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 30 Dec 2015 11:22:34 +0000
Subject: [PATCH] arm64: Add DT support for Juno r2 board
In-Reply-To: <20151229183521.GL12450@rob-hp-laptop>
References: <1450872611-15326-1-git-send-email-sudeep.holla@arm.com>
 <20151229183521.GL12450@rob-hp-laptop>
Message-ID: <5683BE7A.9020404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for the review.

On 29/12/15 18:35, Rob Herring wrote:
> On Wed, Dec 23, 2015 at 12:10:11PM +0000, Sudeep Holla wrote:
>> Juno r2 is identical to Juno r1 with Cortex A57 cores replaced by
>> Cortex A72 cores.
>
> That's a bigger change than I'd expect...
>

I am not sure if I understood what you meant by that. Do you want me to
elaborate with more details ?

>> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/arm-boards |   1 +
>>   Documentation/devicetree/bindings/arm/cpus.txt   |   1 +
>
> This should probably be a separate patch, but I already have a patch in
> my tree for 4.5 adding arm,cortex-a72. So just drop this hunk.
>

OK, will post DT binding separately.

>>   arch/arm64/boot/dts/arm/Makefile                 |   2 +-
>>   arch/arm64/boot/dts/arm/juno-r2.dts              | 200 +++++++++++++++++++++++
>>   4 files changed, 203 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm64/boot/dts/arm/juno-r2.dts
>
> [...]
>
>> +	pmu_a72 {
>> +		compatible = "arm,cortex-a72-pmu";
>
> This needs to be documented.
>

Yes, Will is already carrying a patch in his tree to add this [1]

>> +	pcie-controller at 40000000 {
>> +		compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi", "pci-host-ecam-generic";
>
> Is this common with r1?
>

AFAIK it is. Liviu can you confirm ?

Regards,
Sudeep

[1] 
https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=for-next/perf&id=5d7ee87708d4d86fcc32afc9552d05f7625d303d
-- 

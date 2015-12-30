From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Dec 2015 09:09:46 -0600
Subject: [PATCH] arm64: Add DT support for Juno r2 board
In-Reply-To: <5683BE7A.9020404@arm.com>
References: <1450872611-15326-1-git-send-email-sudeep.holla@arm.com>
 <20151229183521.GL12450@rob-hp-laptop> <5683BE7A.9020404@arm.com>
Message-ID: <CAL_Jsq+RZk3LnOhGtiXRFmxmA6bTOEdymtF1yN=6q=iRmUr_9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2015 at 5:22 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Rob,
>
> Thanks for the review.
>
> On 29/12/15 18:35, Rob Herring wrote:
>>
>> On Wed, Dec 23, 2015 at 12:10:11PM +0000, Sudeep Holla wrote:
>>>
>>> Juno r2 is identical to Juno r1 with Cortex A57 cores replaced by
>>> Cortex A72 cores.
>>
>>
>> That's a bigger change than I'd expect...
>>
>
> I am not sure if I understood what you meant by that. Do you want me to
> elaborate with more details ?

No, just my commentary that I'd expect r1 -> r2 to be a board or Si
spin rather than a whole new core.

>>> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/arm-boards |   1 +
>>>   Documentation/devicetree/bindings/arm/cpus.txt   |   1 +
>>
>>
>> This should probably be a separate patch, but I already have a patch in
>> my tree for 4.5 adding arm,cortex-a72. So just drop this hunk.
>>
>
> OK, will post DT binding separately.

No need, it is already in my tree.

>>> +       pcie-controller at 40000000 {
>>> +               compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi",
>>> "pci-host-ecam-generic";
>>
>>
>> Is this common with r1?
>>
>
> AFAIK it is. Liviu can you confirm ?

Then perhaps you should move this to a common spot.

Rob

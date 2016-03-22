From: robh@kernel.org (Rob Herring)
Date: Tue, 22 Mar 2016 07:44:37 -0500
Subject: [PATCH v2 3/5] dt-bindings: Add documentation for GM20B GPU
In-Reply-To: <56F0C375.1030907@nvidia.com>
References: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
 <1458010724-10945-4-git-send-email-acourbot@nvidia.com>
 <20160318204748.GA20243@rob-hp-laptop>
 <CAAVeFuKQvjb20aEh9_MBnrzEUjKoVc8yQu3a4Ego6Qaqe70M6A@mail.gmail.com>
 <CAL_Jsq+SEOC1s_j8u3hMyDj5i9ROyAAN_-qmbsLrNvR3v2cXwA@mail.gmail.com>
 <56F0C375.1030907@nvidia.com>
Message-ID: <CAL_JsqKRm8cERK0JdvEym1e1SUgnis_MWW_t7Bfn5v6+qDfaew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 11:00 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> On 03/22/2016 10:41 AM, Rob Herring wrote:
>>
>> On Sun, Mar 20, 2016 at 1:55 AM, Alexandre Courbot <gnurou@gmail.com>
>> wrote:
>>>
>>> On Sat, Mar 19, 2016 at 5:47 AM, Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Tue, Mar 15, 2016 at 11:58:42AM +0900, Alexandre Courbot wrote:
>>>>>
>>>>> GM20B's definition is mostly similar to GK20A's, but requires an
>>>>> additional clock.
>>
>>
>> [...]
>>
>>>>>        gpu at 0,57000000 {
>>>>>                compatible = "nvidia,gk20a";
>>>>> @@ -45,3 +49,22 @@ Example:
>>>>>                iommus = <&mc TEGRA_SWGROUP_GPU>;
>>>>>                status = "disabled";
>>>>>        };
>>>>> +
>>>>> +Example for GM20B:
>>>>> +
>>>>> +     gpu at 0,57000000 {
>>>>
>>>>
>>>> Drop the comma and leading zero.
>>>
>>>
>>> Even though this is how it appears in the actual DT?
>>
>>
>> Yes, those will need to get fixed, too.
>
>
> Sorry, I just want to confirm that I understand why this needs to be fixed.
> The parent node has #address-cells = <2>, and the practice of specifying two
> cells in the node name is consistent with what I see in
> http://www.devicetree.org/Device_Tree_Usage.
>
> However in the device tree usage example one can interpret the two cells as
> being two different components of the address, whereas in our case we are
> using two cells because the address is 64-bit - hence we should specify it
> in the name as a single entity. Is this correct?

Exactly, commas are for separating distinct fields like chip select
and offset in the wiki example. A 64-bit address is a single field.

The other reason to fix it is dtc is going to start warning for this.

Rob

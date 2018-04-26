From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 26 Apr 2018 10:01:32 -0500
Subject: [PATCH 1/3] Documentation: dt: socfpga: Add Stratix10 ECC Manager
 binding
In-Reply-To: <64ecc830-3674-6bb4-c2f9-c24e576c08c0@linux.intel.com>
References: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
 <1524594959-5259-2-git-send-email-thor.thayer@linux.intel.com>
 <6528e94e-85ea-8015-5a3b-4e8a9ecc8dbd@kernel.org>
 <e9606cfb-cee6-2e0c-cfe5-c91a537cb8a2@linux.intel.com>
 <64ecc830-3674-6bb4-c2f9-c24e576c08c0@linux.intel.com>
Message-ID: <8f29ed5c-4e21-6200-23dc-4cadf86d2b96@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/26/2018 09:58 AM, Thor Thayer wrote:
> On 04/26/2018 09:43 AM, Thor Thayer wrote:
>> On 04/25/2018 09:16 PM, Dinh Nguyen wrote:
>>>
>>>
>>> On 04/24/2018 01:35 PM, thor.thayer at linux.intel.com wrote:
>>>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>>>
>>>> Add the device tree bindings needed to support the Stratix10
>>>> ECC Manager and SDRAM ECC to the existing bindings.
>>>>
>>>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>>>> ---
>>>> ? .../bindings/arm/altera/socfpga-eccmgr.txt???????? | 47
>>>> ++++++++++++++++++++++
>>>> ? 1 file changed, 47 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
>>>> b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
>>>> index 4a1714f96bab..fe48ad293a24 100644
>>>> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
>>>> @@ -231,3 +231,50 @@ Example:
>>>> ?????????????????????? <48 IRQ_TYPE_LEVEL_HIGH>;
>>>> ????????? };
>>>> ????? };
>>>> +
>>>> +Stratix10 SoCFPGA ECC Manager
>>>> +The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
>>>> +in a shared register similar to the Arria10. However, ECC requires
>>>> +access to registers that can only be read in EL3 with SMC calls.
>>>> +Therefore the device tree is slightly different.
>>>> +
>>>> +Required Properties:
>>>> +- compatible : Should be "altr,socfpga-s10-ecc-manager"
>>>
>>> Altera technically doesn't exist anymore, should this be
>>> "intel,stratix10-ecc-manager"?
>>>
>> I was trying to be consistent with the older names but I agree with
>> your argument. I will change this. Thanks
>>
> After looking at the Stratix10 device tree, there are only "altr," in
> there. For instance the top node is:
> 
> compatible = "altr,socfpga-stratix10";
> 
> and even the directory that the device tree is in is named "altera"
> 
> so I'll stick with the existing "altr," designation to be consistent.
> 

That's fine and I don't have any strong inclination for 1 way or
another. But it's not quite true that there are only "altr" in the dts file.

I did recently switch the clock manager to an intel designation. I
upstreamed the original stratix10 DTS file back in 2015, before Altera
was purchased by Intel.

My only argument is that if you're adding new support for devices, it
should be an intel binding.

Dinh

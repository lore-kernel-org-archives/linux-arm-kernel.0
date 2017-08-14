From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 14 Aug 2017 16:35:34 +0200
Subject: [PATCH 1/3] dt: xilinx: zynqmp: Add bindings for PM firmware
In-Reply-To: <CABGGiszb1kr8ggo8Jv9jsvStK5DxpseuBy7z=_OK8pLN==h25Q@mail.gmail.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <8c27b7eec6cc00d37dfe9b3998212ce9c9c27a31.1501854302.git.michal.simek@xilinx.com>
 <20170810191056.ur5b3zdrcgmb6sim@rob-hp-laptop>
 <4e5d9f8c-9e87-bdcd-388a-aab3c32415e8@xilinx.com>
 <20170811135453.GU12347@toto>
 <5d2e3a5e-6060-ff13-a065-c4b6be37e4c9@xilinx.com>
 <CABGGiszb1kr8ggo8Jv9jsvStK5DxpseuBy7z=_OK8pLN==h25Q@mail.gmail.com>
Message-ID: <dd6173f6-7ae2-913a-321d-ec1e492af629@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.8.2017 16:03, Rob Herring wrote:
> On Mon, Aug 14, 2017 at 8:47 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 11.8.2017 15:54, Edgar E. Iglesias wrote:
>>> On Fri, Aug 11, 2017 at 02:58:03PM +0200, Michal Simek wrote:
>>>> Hi Rob, +Edgar,
>>>>
>>>> On 10.8.2017 21:10, Rob Herring wrote:
>>>>> On Fri, Aug 04, 2017 at 03:45:30PM +0200, Michal Simek wrote:
>>>>>> From: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>>>>
>>>>>> Document the DT bindings for the Zynq UltraScale+ PM Firmware.
> 
> [...]
> 
>>>>>> + - method:        The method of calling the PM-API firmware layer.
>>>>>> +          Permitted values are:
>>>>>> +           - "smc" : To be used in configurations without a hypervisor
>>>>>> +           - "hvc" : To be used when hypervisor is present
>>>>>
>>>>> Do you really use both?
>>>>>
>>>>
>>>> SMCs definitely yes.
>>>>
>>>> Interface was designed in that way and I don't know if people are using
>>>> it or not.
>>>>
>>>> Not sure if Xen is blocking SMCs. I know we have discussed it but not
>>>> sure if this is enabled by default or only for certain configurations.
>>>> Also not sure if xen contains handler for hvc.
>>>> Edgar: Do you know?
>>>
>>> We have patches for Xen that implement a power-management mediator.
>>> That implementation handles PM calls over both SMC and HVC insns.
>>> Patches are on the Xen mailing list.
>>>
>>> Other hypervisors may work differently.
>>>
>>> I think we should support both but I don't have a strong opinion on it.
>>
>> Rob: Are you ok with having it there?
> 
> Yes.

Ok. Let me send v2 then.

Thanks,
Michal

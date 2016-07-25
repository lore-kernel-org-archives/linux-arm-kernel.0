From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 25 Jul 2016 14:09:18 +0100
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <20160725121045.GG21170@ulmo.ba.sec>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <434561ec-510e-a3bf-c7b6-c961db299bd6@nvidia.com>
 <CALw8SCU0cz6mbO=oudCZ4-=2PHVORNt3gwmg2bzNjyhJFnWS3g@mail.gmail.com>
 <20160725121045.GG21170@ulmo.ba.sec>
Message-ID: <43ce209d-1b11-ab9b-0e80-8f7fad45eb41@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25/07/16 13:10, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Jul 21, 2016 at 10:10:49PM +0200, Mirza Krak wrote:
>> 2016-07-21 11:56 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>>>> +
>>>> +The NOR controller supports a number of memory types, including synchronous NOR,
>>>> +asynchronous NOR, and other flash memories with similar interfaces, such as
>>>> +MuxOneNAND. One could also connect high speed devices like FPGAs, DSPs,
>>>> +CAN chips, Wi-Fi chips etc.
>>>
>>> Nit-pick ... the Tegra documentation refers to this controller as the
>>> GMI (general memory interface) or SNOR (sync-NOR) controller because it
>>> is not just limited to NOR as you mentioned. I see references to GMI in
>>> the Tegra pinctrl driver and so may be we should use this name.
>>
>> ACK.
>>
>>
>>>> +Required properties:
>>>> +
>>>> + - compatible: should be "nvidia,tegra20-nor", "nvidia,tegra30-nor"
>>>
>>> I see at least one difference at the register level between Tegra20 and
>>> Tegra30 and so I think this should be something like ...
>>>
>>>  - compatible : Should contain one of the following:
>>>         For Tegra20 must contain "nvidia,tegra20-gmi".
>>>         For Tegra30 must contain "nvidia,tegra30-gmi".
>>
>> ACK. Just curious, which register was it? I only checked that they
>> have the same count of registers.
>>
>>>> + - nvidia,config: This property represents the SNOR_CONFIG_0 register.
>>>
>>> There is also a SNOR_MIO_CONFIG for the MIO address space and so I think
>>> that this should be nvidia,snor-config to be explicit. It might be nice
>>> to also add a "nvidia,mio-config" while you are at it as well, however,
>>> that could always be done later. If you do, then the
>>> "nvidia,snor-config" becomes optional depending on whether you are using
>>> the SNOR or MIO address space.
>>
>> ACK the nvidia,snor-config part, will though wait for further comments
>> regarding what to do with the config registers, break-out or keep it
>> is a one property / register.
>>
>> Regarding mio-config, not sure about if I would like to include that
>> part in this stage. If you feel strongly about this we can do it. If
>> it only comes to down to replicate the same configurations that we do
>> for SNOR to MIO then I do not see much of a problem, but would like
>> SNOR to be accepted and would not like the MIO part to halt this. But
>> then again this up to you guys.
> 
> What's the difference between SNOR and MIO? Sorry if I'm being dense but
> a quick look around the internet didn't yield anything related. I'd be
> happy to read up if somebody can provide a link.

I am not sure where this term MIO comes from (may be an NVIDIA term),
but from looking at the MIO_CONFIG register, it looks like a basic
16/32-bit interface with configurable read/write strobe timing. Does not
support bursting or address/data multiplexing that the SNOR interface
does. So may be it is used for interfacing to external devices such as
FIFOs, UARTs, I2C expanders, etc.

Cheers
Jon

-- 
nvpublic

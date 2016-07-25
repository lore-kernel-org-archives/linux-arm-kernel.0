From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 25 Jul 2016 09:14:27 +0100
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <CALw8SCXb29NM=BRnUBsnFFObe25fSFi2mzvhrb5CvvJVCcWRfA@mail.gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <434561ec-510e-a3bf-c7b6-c961db299bd6@nvidia.com>
 <CALw8SCU0cz6mbO=oudCZ4-=2PHVORNt3gwmg2bzNjyhJFnWS3g@mail.gmail.com>
 <8e9cdefd-68d1-b788-92fb-b74aae1713c8@nvidia.com>
 <CALw8SCXb29NM=BRnUBsnFFObe25fSFi2mzvhrb5CvvJVCcWRfA@mail.gmail.com>
Message-ID: <88fb7138-f2b4-b51c-307b-5ef69b953498@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 22/07/16 20:07, Mirza Krak wrote:
> 2016-07-22 11:32 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>>
>> On 21/07/16 21:10, Mirza Krak wrote:
>>> 2016-07-21 11:56 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>>>>
>>>> I wonder if it is worth mentioning that the chip-select specified in the
>>>> "nvidia,config" prop should match that in the "ranges" prop unless you
>>>> have some external decoding logic to provide an external chip-select.
>>>> Which raises a question, what does the chip-select in the ranges
>>>> actually represent? I am not sure if there is a common practice here for
>>>> device tree when boards have external logic to provide additional
>>>> chip-selects. I am sure this is quite common.
>>>
>>> I do not understand why CS pin setting in nvidia,config need to match
>>> the "ranges" prop? Other then maybe cosmetics.
>>
>> Yes it would be cosmetic. That said, I even wonder if CS needs to be
>> exposed at all given that they all map to the same CPU address space.
>> Couldn't your binding for the CAN devices be as follows?
>>
>> nor at 70009000 {
>>         ...
>>
>>         can at 48000000 {
>>                 ...
>>         };
>>
>>         can at 48040000 {
>>                 ...
>>         };
>> };
> 
> This has also crossed my mind, maybe just get rid of the "ranges" prop
> and do like you have above. But then again I do not know what is
> preferred so I went with "ranges" prop initially.
> 
> 
>>
>> Problem is if you did have devices on different chip-selects then how
>> would these be handled? They could not point to the same physical
>> address. I am not sure if there is a way to do that in DT?
> 
> Having trouble following your though here. We do not have "different"
> chip-selects?

I meant that the device has multiple chip-selects and so I was not sure
the best way to handle this for the GMI.

Jon

-- 
nvpublic

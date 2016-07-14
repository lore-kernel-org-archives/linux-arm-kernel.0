From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 14 Jul 2016 12:32:57 +0200
Subject: [Xen-devel] [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <57876612.3030407@arm.com>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
 <146836236759.73491.11707389619985827497@resonance>
 <c320f820-8749-f4a4-435e-ddd9379655b5@de.bosch.com>
 <alpine.DEB.2.10.1607131941200.26575@sstabellini-ThinkPad-X260>
 <57868EDE.6060406@gmail.com>
 <146844380895.73491.4867379517577413421@resonance>
 <7df784ab-d0c0-939b-393e-214535c4b191@de.bosch.com>
 <57876612.3030407@arm.com>
Message-ID: <b90f7461-4e6b-c3e3-7a60-a8b4082ec196@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.07.2016 12:14, Julien Grall wrote:
> Hi Dirk,
>
> On 14/07/16 07:31, Dirk Behme wrote:
>> On 13.07.2016 23:03, Michael Turquette wrote:
>>> Quoting Dirk Behme (2016-07-13 11:56:30)
>>>> On 13.07.2016 20:43, Stefano Stabellini wrote:
>>>>> On Wed, 13 Jul 2016, Dirk Behme wrote:
>>>>>> On 13.07.2016 00:26, Michael Turquette wrote:
>>>>>>> Quoting Dirk Behme (2016-07-12 00:46:45)
>>>>>>>> Clocks described by this property are reserved for use by Xen,
>>>>>>>> and the OS
>>>>>>>> must not alter their state any way, such as disabling or gating a
>>>>>>>> clock,
>>>>>>>> or modifying its rate. Ensuring this may impose constraints on
>>>>>>>> parent
>>>>>>>> clocks or other resources used by the clock tree.
>>>>>>>
>>>>>>> Note that clk_prepare_enable will not prevent the rate from changing
>>>>>>> (clk_set_rate) or a parent from changing (clk_set_parent). The
>>>>>>> only way
>>>>>>> to do this currently would be to set the following flags on the
>>>>>>> effected
>>>>>>> clocks:
>>>>>>>
>>>>>>>     CLK_SET_RATE_GATE
>>>>>>>     CLK_SET_PARENT_GATE
>>>>>>
>>>>>>
>>>>>>
>>>>>> Regarding setting flags, I think we already talked about that. I
>>>>>> think the
>>>>>> conclusion was that in our case its not possible to manipulate the
>>>>>> flags in
>>>>>> the OS as this isn't intended to be done in cases like ours.
>>>>>> Therefore no API
>>>>>> is exported for this.
>>>>>>
>>>>>> I.e. if we need to set these flags, we have to do that in Xen where
>>>>>> we add the
>>>>>> clocks to the hypervisor node in the device tree. And not in the
>>>>>> kernel patch
>>>>>> discussed here.
>>>>>
>>>>> These are internal Linux flags, aren't they?
>>>>
>>>>
>>>> I've been under the impression that you can set clock "flags" via the
>>>> device tree. Seems I need to re-check that ;)
>>>
>>> Right, you cannot set flags from the device tree. Also, setting these
>>> flags is done by the clock provider driver, not a consumer. Xen is the
>>> consumer.
>>
>>
>> Ok, thanks, then I think we can forget about using flags for the issue
>> we are discussing here.
>>
>> Best regards
>>
>> Dirk
>>
>> P.S.: Would it be an option to merge the v4 patch we are discussing
>> here, then? From the discussion until here, it sounds to me that it's
>> the best option we have at the moment. Maybe improving it in the future,
>> then.
>
> I think it is a good start, although I would like to see some rationale
> in the code and commit message about the behavior of the Linux with
> those clocks after this patch because it does not match the "contract".


I'd be happy about any wording proposals :)


Best regards

Dirk

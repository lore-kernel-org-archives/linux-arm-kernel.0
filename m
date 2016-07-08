From: julien.grall@arm.com (Julien Grall)
Date: Fri, 8 Jul 2016 11:49:33 +0100
Subject: [PATCH v3] xen/arm: enable clocks used by the hypervisor
In-Reply-To: <437b5eff-4294-3493-b1b2-0ff2c10525e3@de.bosch.com>
References: <1467963871-31556-1-git-send-email-dirk.behme@de.bosch.com>
 <577F73B3.8090807@arm.com>
 <437b5eff-4294-3493-b1b2-0ff2c10525e3@de.bosch.com>
Message-ID: <577F853D.405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/07/16 11:40, Dirk Behme wrote:
> Hi Michael and Julien,
>
> On 08.07.2016 11:34, Julien Grall wrote:
>> Hi Dirk,
>>
>> On 08/07/16 08:44, Dirk Behme wrote:
>>> Xen hypervisor drivers might replace native OS drivers. The result is
>>> that some important clocks that are enabled by the OS in the non-Xen
>>> case are not properly enabled in the presence of Xen. The clocks
>>> property enumerates the clocks that must be enabled by the Xen clock
>>> consumer.
>>>
>>> An example is a serial driver enabled by the hypervisor. Xen must
>>
>> I would say "An example is the UART used by the hypervisor."
>>
>>> consume and enable these clocks in the OS to ensure behavior continues
>>> after firmware configures the UART hardware and corresponding clock
>>> harder.
>>
>> What do you mean by "harder"?
>>
>> Also, relying on DOM0 to enable the clock looks very wrong to me and you
>> give an example which prove that. The UART will be used before hand by
>> Xen, however it will not be possible to use it if you expect DOM0 to
>> enable the clock (or even modify the clock frequency).
>>
>> The clock should be enabled either by the firmware or Xen. But not DOM0.
>> DOM0 should not touch this clock at all.
>>
>> Furthermore, this property could be used for clock associated to device
>> that will be passthrough-ed to a guest. In this case, the clock would be
>> enabled even if the device is not in use which will result more power
>> consumption.
>
>
> I took the description directly from Michael's proposal
>
> http://www.spinics.net/lists/arm-kernel/msg516576.html
>
> Would it be possible that you two experts agree on the exact wording you
> like to see?

I think the wording suggested by Mark in [1] represents better what we 
would like to achieve with this property.

Regards,

[1] https://www.spinics.net/lists/arm-kernel/msg516158.html

-- 
Julien Grall
